module Network.CryptoNote.Crypto.Types ( Hash
                                       , Signature
                                       , PublicKey
                                       , KeyImage
                                       ) where

import Data.LargeWord

-- crypto/hash.h

type Hash = Word256

-- STUB
data Signature = Signature
                 deriving (Eq, Show)

-- STUB
data PublicKey = PublicKey
                 deriving (Eq, Show)

-- STUB
data KeyImage = KeyImage
                deriving (Eq, Show)
