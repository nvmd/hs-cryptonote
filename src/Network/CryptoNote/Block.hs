module Network.CryptoNote.Block where

import Network.CryptoNote.Crypto.Hash (cryptoNightFast)
import Network.CryptoNote.Crypto.Types (Hash)
import Network.CryptoNote.Identifiable
import Network.CryptoNote.Transaction

import Data.Word (Word64, Word32, Word8)

import Data.Binary (Binary(..), encode)
import Data.ByteString.Lazy (toStrict)

-- cryptonote_core/cryptonote_basic.h

data BlockHeader = BlockHeader { majorVersion :: Word8
                               , minorVersion :: Word8
                               , timestamp    :: Word64
                               , prevId       :: Hash
                               , nonce        :: Word32
                               } deriving (Eq, Show)

data Block = Block { header   :: BlockHeader
                   , minerTx  :: Transaction
                   , txHashes :: [Hash]
                   } deriving (Eq, Show)

instance Identifiable Block where
  id = cryptoNightFast . toStrict . encode

instance Binary Block where
  put = undefined
  get = undefined
