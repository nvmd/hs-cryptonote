module Network.CryptoNote.P2P.Notify.NewTransactions where

import Data.ByteString


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 2;
data NotifyNewTransactions = NotifyNewTransactions
    { txs :: [ByteString]
    } deriving (Show, Eq)
