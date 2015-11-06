{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Network.CryptoNote.Transaction.Input where

import Network.CryptoNote.Crypto.Types (KeyImage)

import Data.Word (Word64)

import Data.Aeson
import Data.Aeson.Types (typeMismatch)
import GHC.Generics


-- cryptonote_core/cryptonote_basic.h

data TransactionInput = TIGen              TransactionInFromGen
                      | TIToKey            TransactionInFromKey
                      -- | TIToMultisignature TransactionInFromMultisignature -- latest
                      -- | TIToScript         TransactionInFromScript -- unused
                      -- | TIToScriptHash     TransactionInFromScriptHash -- unused
                      deriving (Eq, Show)

data TransactionInFromGen = TransactionInFromGen {
  height :: Word64 -- size_t. uint32_t in bytecoin
} deriving (Eq, Show, Generic)

data TransactionInFromKey = TransactionInFromKey {
  amount         :: Word64,
  outputsIndexes :: [Word64], -- a.k.a keyOffsets. uint64_t. uint32_t in bytecoin
  keyImage       :: KeyImage -- double-spending protection
} deriving (Eq, Show, Generic)


instance ToJSON TransactionInput where
  toJSON (TIGen gen)   = object [ "gen" .= gen ]
  toJSON (TIToKey key) = object [ "key" .= key ]
  -- TODO: toEncoding

instance FromJSON TransactionInput where
  parseJSON (Object _) = undefined  -- TODO
  parseJSON invalid    = typeMismatch "TransactionInput" invalid


instance ToJSON TransactionInFromGen where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TransactionInFromGen


instance ToJSON TransactionInFromKey where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TransactionInFromKey


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
