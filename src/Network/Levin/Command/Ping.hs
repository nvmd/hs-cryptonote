module Network.Levin.Command.Ping where

import Network.Levin.Peer (PeerId)


-- net_node.h
-- p2p_protocol_defs.h


-- Used to make "callback" connection, to be sure that opponent node
-- have accessible connection point. Only other nodes can add peer to peerlist,
-- and ONLY in case when peer has accepted connection and answered to ping.
-- #define P2P_COMMANDS_POOL_BASE 1000
-- const static int ID = P2P_COMMANDS_POOL_BASE + 3;
data CommandPing = CommandPingReq
                 | CommandPingResp
                   { status :: String
                   , peerId :: PeerId
                   }
                 deriving (Show, Eq)

