module Network.Levin.Command.Debug where

import Data.Word (Word64)
import Data.Binary (Binary)

import Network.Levin.Peer (PeerId)


-- net_node.h
-- p2p_protocol_defs.h


-- #ifdef ALLOW_DEBUG_COMMANDS
-- These commands are considered as insecure, and made in debug purposes for a limited lifetime.
-- Anyone who feel unsafe with this commands can disable the ALLOW_GET_STAT_COMMAND macro.

data Binary s =>
     ProofOfTrust s = ProofOfTrust
         { peerId    :: PeerId
         , time      :: Word64
         , signature :: s       -- ^ Network.CryptoNote.Crypto.Types (Signature)
         } deriving (Show, Eq)

data CommandRequestStatInfo p = CommandRequestStatInfo

data CommandRequestNetworkState = CommandRequestNetworkState

data CommandRequestPeerId = CommandRequestPeerIdReq
                          | CommandRequestPeerIdResp
                            { peerId :: PeerId
                            }
