module Network.CryptoNote.Crypto.Types ( Hash
                                       , PublicKey
                                       , SecretKey
                                       , KeyDerivation
                                       , KeyImage
                                       , Signature
                                       ) where

import Data.LargeWord

-- crypto/hash.h

type Hash = Word256


type PublicKey = Word256

type SecretKey = Word256

type KeyDerivation = Word256

type KeyImage = Word256

type Signature = LargeKey Word256 Word256
