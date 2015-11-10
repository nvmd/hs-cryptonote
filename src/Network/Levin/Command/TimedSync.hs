module Network.Levin.Command.TimedSync where

import Data.Word (Word64)
import Data.Binary (Binary)

import Network.Levin.Peer (Peer)


-- net_node.h
-- p2p_protocol_defs.h


-- #define P2P_COMMANDS_POOL_BASE 1000
-- const static int ID = P2P_COMMANDS_POOL_BASE + 2;
data Binary p =>
     CommandTimedSync p = CommandTimedSyncReq
                          { payloadData :: p
                          }
                        | CommandTimedSyncResp
                          { localTime     :: Word64
                          , payloadData   :: p
                          , localPeerList :: [Peer]
                          }
                        deriving (Show, Eq)
