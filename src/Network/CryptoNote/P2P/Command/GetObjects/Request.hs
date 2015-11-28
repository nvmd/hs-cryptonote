module Network.CryptoNote.P2P.Command.GetObjects.Request where

import Network.CryptoNote.Crypto.Hash (Hash, Id)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 3;
data RequestGetObjects = RequestGetObjects
    { txs    :: [Hash Id]
    , blocks :: [Hash Id]
    } deriving (Show, Eq)
