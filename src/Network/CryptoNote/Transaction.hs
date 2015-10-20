module Network.CryptoNote.Transaction where

import Network.CryptoNote.Identifiable
import Network.CryptoNote.Crypto.Types (Signature)
import Network.CryptoNote.Transaction.Input (TransactionInput)
import Network.CryptoNote.Transaction.Output (TransactionOutput)
import Network.CryptoNote.Crypto.Hash (cryptoNightFast)

import Data.Word (Word64, Word8)
import Data.ByteString

import Data.Binary (Binary(..), encode)
import Data.ByteString.Lazy (toStrict)


-- cryptonote_core/cryptonote_basic.h

data TransactionPrefix = TransactionPrefix {
  version    :: Word64,
  unlockTime :: Word64,
  inputs     :: [TransactionInput],
  outputs    :: [TransactionOutput],
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
