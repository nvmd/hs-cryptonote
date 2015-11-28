module Network.CryptoNote.P2P.Notify.NewBlock where

import Data.ByteString
import Data.Word (Word64, Word32)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

data BlockCompleteEntry = BlockCompleteEntry
    { block :: ByteString
    , txss  :: [ByteString]
    } deriving (Show, Eq)

-- #define BC_COMMANDS_POOL_BASE 2000
-- const static int ID = BC_COMMANDS_POOL_BASE + 1;
data NotifyNewBlock = NotifyNewBlock
    { blockCompleteEntry      :: BlockCompleteEntry
    , currentBlockchainHeight :: Word64
    , hop                     :: Word32
    } deriving (Show, Eq)
