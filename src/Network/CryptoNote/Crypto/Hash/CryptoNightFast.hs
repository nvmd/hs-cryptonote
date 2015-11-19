{-# LANGUAGE CPP #-}

module Network.CryptoNote.Crypto.Hash.CryptoNightFast ( hash ) where

#if defined(USE_FFI_CRYPTO)
import qualified Network.CryptoNote.Crypto.Hash.FFI as FFI
#else
import Crypto.Hash (hashWith)
import Crypto.Hash.Algorithms (Keccak_256 (..))
import Data.ByteArray (convert)
import Data.Binary (decode)
import Data.ByteString.Lazy (fromStrict)
#endif
import Network.CryptoNote.Crypto.Hash.Types (RawHash)
import Data.ByteString


#if !defined(USE_FFI_CRYPTO)
hash :: ByteString -> RawHash
hash = decode . fromStrict . convert . hashWith Keccak_256
#else
hash :: ByteString -> RawHash
hash = FFI.cnFastHash
#endif
