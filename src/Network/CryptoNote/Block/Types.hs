module Network.CryptoNote.Block.Types ( BlockHeader (..)
                                      , Block (..)
                                      , hashingBlob
                                      ) where

import Network.CryptoNote.Crypto.Hash (cryptoNightFast, tree)
import Network.CryptoNote.Crypto.Types (Hash)
import Network.CryptoNote.Identifiable as Id
import Network.CryptoNote.Transaction
import Network.CryptoNote.Types (toVarInt)

import Data.Word (Word64, Word32, Word8)

import Data.Binary (Binary(..), encode)
import Data.ByteString.Lazy as BL (ByteString, toStrict, concat)


-- CryptoNote.h
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
  id = cryptoNightFast . toStrict . hashingBlob

instance Binary Block where
  put = undefined
  get = undefined


-- cryptonote_core/cryptonote_format_utils.cpp

-- get_block_hashing_blob
hashingBlob :: Block -> ByteString
hashingBlob block = BL.concat [blockBlob, treeRootBlob, txCountBlob]
                  where treeRootHash = txTreeHash block
                        txCount      = length (txHashes block) + 1
                        blockBlob    = encode block
                        treeRootBlob = encode treeRootHash
                        txCountBlob  = encode $ toVarInt txCount

-- get_tx_tree_hash
txTreeHash :: Block -> Hash
txTreeHash b = tree (Id.id (minerTx b) : txHashes b)
