{-# LANGUAGE DeriveGeneric #-}

module Network.CryptoNote.Transaction where

import Network.CryptoNote.Identifiable
import Network.CryptoNote.Crypto.Types (Signature)
import Network.CryptoNote.Transaction.Input (TransactionInput)
import Network.CryptoNote.Transaction.Output (TransactionOutput)
import Network.CryptoNote.Crypto.Hash (hash)

import Data.Word (Word64, Word8)

import Data.Binary (Binary(..), encode)
import Data.ByteString.Lazy (toStrict)
import Data.Aeson (ToJSON (..),
                   FromJSON (..),
                   genericToEncoding,
                   defaultOptions)
import GHC.Generics


-- cryptonote_core/cryptonote_basic.h

data TransactionPrefix = TransactionPrefix {
  version    :: Word64,
  unlockTime :: Word64,
  inputs     :: [TransactionInput],
  outputs    :: [TransactionOutput],
  extra      :: [Word8]
} deriving (Eq, Show, Generic)

data Transaction = Transaction {
  prefix     :: TransactionPrefix,
  signatures :: [[Signature]]
} deriving (Eq, Show, Generic)


instance Identifiable Transaction where
  id = hash . toStrict . encode


instance Binary Transaction where
  put = undefined
  get = undefined


instance ToJSON TransactionPrefix where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON TransactionPrefix


instance ToJSON Transaction where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Transaction
