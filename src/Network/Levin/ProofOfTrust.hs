module Network.Levin.ProofOfTrust where

import Data.Word (Word64)
import Data.Binary (Binary)

import Network.Levin.Peer (PeerId)


-- net_node.h
-- p2p_protocol_defs.h


-- #ifdef ALLOW_DEBUG_COMMANDS

data Binary s =>
     ProofOfTrust s = ProofOfTrust
         { peerId    :: PeerId
         , time      :: Word64
         , signature :: s       -- ^ Network.CryptoNote.Crypto.Types (Signature)
         } deriving (Show, Eq)
