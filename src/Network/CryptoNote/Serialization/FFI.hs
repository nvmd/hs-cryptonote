{-# LANGUAGE ForeignFunctionInterface #-}

module Network.CryptoNote.Serialization.FFI ( blockToBlob
                                            , txToBlob
                                            ) where

import Foreign
import Foreign.Storable
import Foreign.C
import Foreign.Ptr

import System.IO.Unsafe

import Network.CryptoNote.Block.Types as Block
import Network.CryptoNote.Transaction as Tx
import qualified Network.CryptoNote.Transaction.Input as TxIn
import qualified Network.CryptoNote.Transaction.Output as TxOut

import Data.ByteString

-- #include "cryptonote_serialization_wrappers.h"

type BlobSizeOut = Ptr CInt


foreign import ccall unsafe "cn_serialize_block_to_blob"
  c_cn_serialization_block_to_blob :: Ptr () -> Ptr CChar -> BlobSizeOut -> IO CInt

blockToBlob :: Block -> ByteString
blockToBlob _ = empty -- TODO


foreign import ccall unsafe "cn_serialize_block_to_blob"
  c_cn_serialization_tx_to_blob :: Ptr () -> Ptr CChar -> BlobSizeOut -> IO CInt

txToBlob :: Transaction -> ByteString
txToBlob _ = empty -- TODO
