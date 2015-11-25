module Network.CryptoNote.Crypto.Hash.CryptoNightSlow ( hash ) where

import qualified Network.CryptoNote.Crypto.Hash.FFI as FFI
import Network.CryptoNote.Crypto.Hash.Types (RawHash)
import Data.ByteString

hash :: ByteString -> RawHash
hash = FFI.cnSlowHash
