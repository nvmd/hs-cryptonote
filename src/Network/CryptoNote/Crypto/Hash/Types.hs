module Network.CryptoNote.Crypto.Hash.Types where

import Data.LargeWord
import Data.ByteString
import Data.Binary (Binary (..))
import Control.Applicative ((<$>))


-- CryptoTypes.h
-- crypto/hash.h

data HashAlgorithm a =>
     Hash a = Hash Word256
              deriving (Eq, Ord, Show)

instance Binary (Hash a) where
  put (Hash w) = put w
  get          = Hash <$> get



class HashAlgorithm a where
  hash :: ByteString -> Hash a
  -- hashFromByteString :: BytesString -> Maybe (Hash a)


-- CryptoTypes.h
-- crypto/hash.h

type RawHash = Word256
