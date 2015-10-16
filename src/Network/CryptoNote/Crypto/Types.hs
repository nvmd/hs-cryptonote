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
} deriving (Eq, Show)

instance Binary Signature where
  put (Signature c r) = do
    put c
    put r
  get = Signature <$> get <*> get


-- crypto/crypto.h

type EllipticCurvePoint = Word256
type EllipticCurveScalar = Word256
