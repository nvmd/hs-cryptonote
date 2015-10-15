module Network.CryptoNote.Crypto.Hash where

import qualified Network.CryptoNote.Crypto.HashFFI as FFI
import Network.CryptoNote.Crypto.Types (Hash (..))
import Data.ByteString

-- crypto/hash.h

cryptoNightFast :: ByteString -> Hash
cryptoNightFast = FFI.cnFastHash

cryptoNightSlow :: ByteString -> Hash
cryptoNightSlow = FFI.cnSlowHash

tree :: [Hash] -> Hash
tree = FFI.treeHash
