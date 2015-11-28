module Network.CryptoNote.P2P.Command.Chain.Response where

import Data.Word (Word64)
import Network.CryptoNote.Crypto.Hash (Hash, Id)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 7;
data ResponseChainEntry = ResponseChainEntry
    { startHeight :: Word64
    , totalHeight :: Word64
    , blockIds    :: [Hash Id]
    } deriving (Show, Eq)
