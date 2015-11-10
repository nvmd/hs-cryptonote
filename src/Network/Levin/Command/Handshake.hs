module Network.Levin.Command.Handshake where

import Data.UUID
import Data.Word (Word32, Word64)
import Data.Binary (Binary)

import Network.Levin.Peer (PeerId, Peer)


-- net_node.h
-- p2p_protocol_defs.h


data BasicNodeData = BasicNodeData
    { networkId :: UUID
    , localTime :: Word64
    , myPort    :: Word32
    , peerId    :: PeerId
    } deriving (Show, Eq)

-- #define P2P_COMMANDS_POOL_BASE 1000
-- const static int ID = P2P_COMMANDS_POOL_BASE + 1;
data Binary p =>
     CommandHandshake p = CommandHandshakeReq
                          { nodeData    :: BasicNodeData
                          , payloadData :: p
                          }
                        | CommandHandshakeResp
                          { nodeData      :: BasicNodeData
                          , payloadData   :: p
                          , localPeerList :: [Peer]
                          }
                        deriving (Show, Eq)
