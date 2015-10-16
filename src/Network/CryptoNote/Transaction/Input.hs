module Network.CryptoNote.Transaction.Input where

import Network.CryptoNote.Crypto.Types (KeyImage)

import Data.Word (Word64, Word32, Word8)


-- cryptonote_core/cryptonote_basic.h

data TransactionInput = TIGen              TransactionInFromGen
                      | TIToKey            TransactionInFromKey
                      -- | TIToMultisignature TransactionInFromMultisignature -- lates
                      -- | TIToScript         TransactionInFromScript -- unused
                      -- | TIToScriptHash     TransactionInFromScriptHash -- unused
                      deriving (Eq, Show)

data TransactionInFromGen = TransactionInFromGen {
  height :: Word64 -- size_t. uint32_t in bytecoin
} deriving (Eq, Show)

data TransactionInFromKey = TransactionInFromKey {
  amount         :: Word64,
  outputsIndexes :: [Word64], -- a.k.a keyOffsets. uint64_t. uint32_t in bytecoin
  keyImage       :: KeyImage
} deriving (Eq, Show)

-- Currently unused, but up-to-date

-- data TransactionInFromMultisignature = TransactionInFromMultisignature {
--   amount         :: Word64,
--   signatureCount :: Word8,
--   outputIndex    :: Word32
-- } deriving (Eq, Show)

-- data TransactionInFromScript = TransactionInFromScript {
--   prev :: Hash,
--   prevOut :: Word64, -- size_t
--   sigSet :: [Word8]
-- } deriving (Eq, Show)
--
-- data TransactionInFromScriptHash = TransactionInFromScriptHash {
--   prev :: Hash,
--   prevOut :: Word64, -- size_t
--   script :: TransactionOutToScript,
--   sigSet :: [Word8]
-- } deriving (Eq, Show)
