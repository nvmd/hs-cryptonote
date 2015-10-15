module Network.CryptoNote.Transaction where

import Network.CryptoNote.Crypto.Hash
import Network.CryptoNote.Crypto.Signature
import Network.CryptoNote.Identifiable

import Data.Word (Word64, Word8)
import Data.ByteString

import Data.Binary (Binary(..), encode)
import Data.ByteString.Lazy (toStrict)

-- cryptonote_core/cryptonote_basic.h

data TransactionInput = TIGen
                      | TIToScript
                      | TIToScriptHash
                      | TIToKey
                      deriving (Eq, Show)

data TransactionOutputTarget = TOTToScript
                             | TOTToScriptHash
                             | TOTToKey
                             deriving (Eq, Show)

data TransactionOutput = TransactionOutput {
  amount :: Word64,
  target :: TransactionOutputTarget
} deriving (Eq, Show)

data TransactionPrefix = TransactionPrefix {
  version    :: Word64,
  unlockTime :: Word64,
  vin        :: [TransactionInput],
  vout       :: [TransactionOutput],
  extra      :: [Word8]
} deriving (Eq, Show)

data Transaction = Transaction {
  prefix     :: TransactionPrefix,
  signatures :: [[Signature]]
} deriving (Eq, Show)

instance Identifiable Transaction where
  id = cryptoNightFast . toStrict . encode

instance Binary Transaction where
  put = undefined
  get = undefined
