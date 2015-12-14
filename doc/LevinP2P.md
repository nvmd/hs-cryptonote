Levin P2P protocol
==================

Constants
---------

`levin_base.header`:
```
LEVIN_SIGNATURE       0x0101010101012101LL  //Bender's nightmare

LEVIN_PROTOCOL_VER_0  0
LEVIN_PROTOCOL_VER_1  1

LEVIN_PACKET_REQUEST  0x00000001
LEVIN_PACKET_RESPONSE 0x00000002


--#define LEVIN_DEFAULT_TIMEOUT_PRECONFIGURED 0  -- invoke timeout (timeout until peer's response)
--#define LEVIN_DEFAULT_MAX_PACKET_SIZE 100000000      //100MB by default
```

`cryptonote_config.h`:
```
--#define P2P_LOCAL_WHITE_PEERLIST_LIMIT                  1000
--#define P2P_LOCAL_GRAY_PEERLIST_LIMIT                   5000

--#define P2P_DEFAULT_CONNECTIONS_COUNT                   12
--#define P2P_DEFAULT_HANDSHAKE_INTERVAL                  60           //seconds
--#define P2P_DEFAULT_PACKET_MAX_SIZE                     50000000     //50000000 bytes maximum packet size

P2P_DEFAULT_PEERS_IN_HANDSHAKE                  250

--#define P2P_DEFAULT_CONNECTION_TIMEOUT                  5000       //5 seconds
--#define P2P_DEFAULT_PING_CONNECTION_TIMEOUT             2000       //2 seconds
--#define P2P_DEFAULT_INVOKE_TIMEOUT                      60*2*1000  //2 minutes
--#define P2P_DEFAULT_HANDSHAKE_INVOKE_TIMEOUT            5000       //5 seconds
--#define P2P_DEFAULT_WHITELIST_CONNECTIONS_PERCENT       70
```

Low-level
---------

-- levin_protocol_handler_async.h : handle_recv
```
protocol_handler::handle_receive():
  case stream_state of:
    head:
      check read buffer size <= max packet size + header size
      read header
        read signature, check signature (match/mismatch)
        read rest of the header
      check header.cb <= max packet size
    body:
      read header.cb bytes (i.e. payload)
      is_response := (header.ver = LEVIN_PROTOCOL_VER_1) and (header.flags = LEVIN_PACKET_RESPONSE)
      case is_response of:
        no: case header.have_to_return of:
              no: handle_notify(header.command, payload)
              yes: (resp_header.return_code, resp_payload) := handle_invoke(header.command, payload)
                   resp_header.cb := resp_payload.size()
                   resp_header.have_to_return := no
                   resp_header.ver := LEVIN_PROTOCOL_VER_1
                   resp_header.flags := LEVIN_PACKET_RESPONSE
                   io.write(resp_header ++ resp_payload)
        yes: handle_response(header.command, payload)
```  


-- levin_protocol_handler_async.h : async_invoke, invoke
```
protocol_handler::invoke(command, payload, invoke_response_handler, timeout):

  header.signature           = LEVIN_SIGNATURE
  header.cb                  = payload.size()
  header.have_to_return_data = yes
  header.flags               = LEVIN_PACKET_REQUEST
  header.command             = command
  header.protocol_version    = LEVIN_PROTOCOL_VER_1

  io.write(header ++ payload)

  save invoke_response_handler with timeout to be called later on response
  call invoke_response_handler if error occured on any of earlier stages
```


-- levin_protocol_handler_async.h : notify
```
protocol_handler::notify(command, payload):
  
  header.signature           = LEVIN_SIGNATURE
  header.cb                  = payload.size()
  header.have_to_return_data = no
  header.flags               = LEVIN_PACKET_REQUEST
  header.command             = command
  header.protocol_version    = LEVIN_PROTOCOL_VER_1

  io.write(header ++ payload)
```


Commands
--------


### Upper level protocol handlers

-- net_node.inl : m_payload_handler.process_payload_sync_data
```
process(req.payload_data):
  ... process to be done ...
```

-- net_node.inl : m_payload_handler.get_stat_info
```
get_stat_info():
  ...
```

-- m_payload_handler.get_payload_sync_data
```
get_payload_sync_data():
  ...
```


### Handshake
Must be sent only once and only by the incoming connection peer (nodes drop connections if sent by outgoing connection peer or sent more than once)

-- net_node.inl : do_handshake_with_peer

-- net_node.inl : handle_handshake
```
node::handle_handshake(req):
  check req.node_data.network_id match our network_id, drop connection otherwise
  check if req came from incoming connection, drop connection otherwise
  check for double handshake: check if we already have req.node_data.peer_id associated with the connection, drop connection otherwise
  process(req.payload_data), drop connection if failed
  associate req.node_data.peer_id with the connection
  ... to be done ...


```


### Timed Sync

-- net_node.inl : do_peer_timed_sync, being run every 1 second

```
node:do_peer_timed_sync(peer):
  req.payload_data = get_payload_sync_data
  invoke_command(peer, req) with handler:
    handle_remote_peerlist(rsp), drop connection if failed
    if connection is outgoing:
      update peer's last seen time
    process(rsp.payload_data)
```

-- net_node.inl : handle_timed_sync
```
node:handle_timed_sync(req):
  process(req.payload_data), drop connection if failed
  rsp.local_time = current time
  rsp.local_peerlist = get first P2P_DEFAULT_PEERS_IN_HANDSHAKE peers from peerlist_manager ordered by last seen time
  rsp.payload_data = get_payload_sync_data()
```


### Ping

-- net_node.inl : try_ping

-- net_node.inl : handle_ping
```
node::handle_ping(req):

  rsp.status = PING_OK_RESPONSE_STATUS_TEXT
  rsp.peer_id = our peer_id
```


### Debug commands


-- net_node.inl : check_trust
```
node::check_trust(proof_of_trust):
  ...
```


#### Stat Info

-- net_node.inl : handle_get_stat_info
```
node::handle_get_stat_info(req):
  check_trust(req.tr), drop connection otherwise
  rsp.connections_count = number of server connections, both incoming and outgoing
  rsp.incoming_connections = number of server incoming connections
  rsp.version = our software version
  rsp.os_version = operating system version
  rsp.payload_info = get_stat_info – get additional information from upper level protocol handler
```


#### Network State

-- net_node.inl : handle_get_network_state
```
node::handle_get_network_state(req):
  check_trust(req.tr), drop connection otherwise
  ...

```


#### PeerId

-- net_node.inl : handle_get_peer_id
```
node::handle_get_peer_id(req):
  rsp.my_id = our peer id
```
