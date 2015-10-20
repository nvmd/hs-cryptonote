{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Network.CryptoNote.Transaction.Output where

import Network.CryptoNote.Crypto.Types (PublicKey)

import Data.Word (Word64, Word8)

import Data.Aeson
import Data.Aeson.Types (typeMismatch)
import GHC.Generics


-- CryptoNote.h
-- cryptonote_core/cryptonote_basic.h

data TransactionOutput = TransactionOutput {
  amount :: Word64,
  target :: TransactionOutputTarget
} deriving (Eq, Show, Generic)

data TransactionOutputTarget = TOTToKey            TransactionOutToKey
                            --  | TOTToMultisignature TransactionOutToMultisignature -- latest
                            --  | TOTToScript         TransactionOutToScript -- unused
                            --  | TOTToScriptHash     TransactionOutToScriptHash -- unused
                             deriving (Eq, Show)

data TransactionOutToKey = TransactionOutToKey {
 key :: PublicKey
} deriving (Eq, Show, Generic)


instance ToJSON TransactionOutput where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TransactionOutput


instance ToJSON TransactionOutputTarget where
  toJSON (TOTToKey key) = object [ "key" .= key ]
  -- TODO: toEncoding

instance FromJSON TransactionOutputTarget where
  parseJSON (Object v) = undefined  -- TODO
  parseJSON invalid    = typeMismatch "TransactionOutputTarget" invalid


instance ToJSON TransactionOutToKey where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TransactionOutToKey


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
