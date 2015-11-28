module Network.CryptoNote.P2P.Command.Chain.Request where

import Network.CryptoNote.Crypto.Hash (Hash, Id)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 6;
data RequestChain = RequestChain
    { blockIds :: [Hash Id] -- IDs of the first 10 blocks
                         -- are sequential, next goes
                         -- with pow(2,n) offset,
                         -- like 2, 4, 8, 16, 32, 64 and so
                         -- on, and the last one is always
                         -- genesis block
    } deriving (Show, Eq)
