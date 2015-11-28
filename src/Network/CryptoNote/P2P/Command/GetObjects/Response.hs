module Network.CryptoNote.P2P.Command.GetObjects.Response where

import Data.ByteString

import Network.CryptoNote.P2P.Notify.NewBlock (BlockCompleteEntry)
import Network.CryptoNote.Crypto.Hash (Hash, Id)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 4;
data ResponseGetObjects = ResponseGetObjects
    { txs        :: [ByteString]
    , blocks     :: [BlockCompleteEntry]
    , missed_ids :: [Hash Id]
    } deriving (Show, Eq)
