{-# LANGUAGE DeriveGeneric #-}

module Network.CryptoNote.Crypto.Types ( Hash
                                       , PublicKey
                                       , SecretKey
                                       , KeyDerivation
                                       , KeyImage
                                       , Signature
                                       ) where

import Data.LargeWord
import Data.Binary (Binary (..))
import Control.Applicative ((<$>), (<*>))

import Data.Aeson
import GHC.Generics

-- crypto/hash.h

type Hash = Word256


-- crypto/crypto.h

type PublicKey = EllipticCurvePoint
type SecretKey = EllipticCurveScalar
type KeyDerivation = EllipticCurvePoint
type KeyImage = EllipticCurvePoint

data Signature = Signature {
  c :: EllipticCurveScalar,
  r :: EllipticCurveScalar
} deriving (Eq, Show, Generic)

instance Binary Signature where
  put (Signature c r) = do
    put c
    put r
  get = Signature <$> get <*> get


-- crypto/crypto.h

type EllipticCurvePoint = Word256
type EllipticCurveScalar = Word256


instance ToJSON (LargeKey a b) where
  toJSON _ = object [] -- TODO
  -- TODO: toEncoding

instance (Num a, Num b) => FromJSON (LargeKey a b) where
  parseJSON _ = return $ LargeKey 0 0 -- TODO


instance ToJSON Signature where
  toEncoding = genericToEncoding defaultOptions

instance FromJSON Signature
