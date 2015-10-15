module Network.CryptoNote.Crypto.Types ( Hash(..)
                                       ) where

import Control.Applicative ((<$>))

import Data.LargeWord
import Data.Binary (Binary (..))

-- crypto/hash.h

type Hash = Word256
