{-# LANGUAGE ForeignFunctionInterface #-}

module Network.CryptoNote.Crypto.HashFFI ( cnFastHash
                                         , cnSlowHash
                                         , treeHash
                                         ) where

import Foreign
import Foreign.Storable
import Foreign.C
import Foreign.Ptr

import System.IO.Unsafe

import Data.ByteString as B hiding (map)
import Data.ByteString.Char8 as BC (pack)
import Data.ByteString.Lazy.Char8 as BLC (fromStrict)
import Data.Binary (encode, decode)

import Network.CryptoNote.Crypto.Types (Hash (..))

#include "hash-ops.h"


type FFIHash = Ptr CChar


-- CryptoNight Hash Functions


foreign import ccall unsafe "cn_fast_hash"
  c_cn_fast_hash :: Ptr () -> Word64 -> FFIHash -> IO ()

cnFastHash :: ByteString -> Hash
cnFastHash = computeCnHash c_cn_fast_hash


foreign import ccall unsafe "cn_slow_hash"
  c_cn_slow_hash :: Ptr () -> Word64 -> FFIHash -> IO ()

cnSlowHash :: ByteString -> Hash
cnSlowHash = computeCnHash c_cn_slow_hash


foreign import ccall unsafe "tree_hash"
  c_tree_hash :: FFIHash -> Word64 -> FFIHash -> IO ()

treeHash :: [Hash] -> Hash
treeHash = undefined


computeCnHash :: (Ptr () -> Word64 -> FFIHash -> IO ()) -> ByteString -> Hash
computeCnHash ffiFunc blob = decode $ fromStrict $ computeCnHashBytes ffiFunc blob

computeCnHashBytes :: (Ptr () -> Word64 -> FFIHash -> IO ()) -> ByteString -> ByteString
computeCnHashBytes ffiFunc blob = unsafePerformIO $
  useAsCString blob $ \blobptr ->
    allocaBytes #{const HASH_SIZE} $ \hashptr -> do
      ffiFunc (castPtr blobptr) (fromIntegral $ B.length blob) hashptr
      cblob <- peekArray #{const HASH_SIZE} hashptr
      return $ BC.pack $ map castCCharToChar cblob
