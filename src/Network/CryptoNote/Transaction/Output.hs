module Network.CryptoNote.Transaction.Output where

import Network.CryptoNote.Crypto.Types (PublicKey)

import Data.Word (Word64, Word8)


-- cryptonote_core/cryptonote_basic.h

data TransactionOutput = TransactionOutput {
  amount :: Word64,
  target :: TransactionOutputTarget
} deriving (Eq, Show)

data TransactionOutputTarget = TOTToKey            TransactionOutToKey
                            --  | TOTToMultisignature TransactionOutToMultisignature -- latest
                            --  | TOTToScript         TransactionOutToScript -- unused
                            --  | TOTToScriptHash     TransactionOutToScriptHash -- unused
                             deriving (Eq, Show)

data TransactionOutToKey = TransactionOutToKey {
 key :: PublicKey
} deriving (Eq, Show)

-- Currently unused, but up-to-date

-- data TransactionOutToMultisignature = TransactionOutToMultisignature {
--   keys :: [PublicKey],
--   sigsRequired :: Word8 -- | Required signatures count
-- } deriving (Eq, Show)
--
-- data TransactionOutToScript = TransactionOutToScript {
--   keys   :: [PublicKey],
--   script :: [Word8]
-- } deriving (Eq, Show)
--
-- data TransactionOutToScriptHash = TransactionOutToScriptHash {
--   hash :: Hash
-- } deriving (Eq, Show)
