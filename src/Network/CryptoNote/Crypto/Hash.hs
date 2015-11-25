module Network.CryptoNote.Crypto.Hash ( HashAlgorithm (..)
                                      , Hash
                                      , CryptoNightFast
                                      , CryptoNightSlow
                                      , CryptoNightTree
                                      , Id
                                      , PoW
                                      , Merkle
                                      , cryptoNightFast
                                      , cryptoNightSlow
                                      , tree
                                      ) where

import Network.CryptoNote.Crypto.Hash.Types

import qualified Network.CryptoNote.Crypto.Hash.CryptoNightSlow as CryptoNightSlow
import qualified Network.CryptoNote.Crypto.Hash.CryptoNightFast as CryptoNightFast
import qualified Network.CryptoNote.Crypto.Hash.CryptoNightTree as CryptoNightTree

import Data.ByteString as B (ByteString)
import Data.ByteString.Lazy.Char8 as BLC (toStrict, concat)
import Data.Binary (encode)


-- crypto/hash.h

cryptoNightFast :: ByteString -> Hash CryptoNightFast
cryptoNightFast = hash

cryptoNightSlow :: ByteString -> Hash CryptoNightSlow
cryptoNightSlow = hash

tree :: HashAlgorithm a => [Hash a] -> Hash CryptoNightTree
tree = hash . toStrict . BLC.concat . map encode


data CryptoNightFast = CryptoNightFast
                       deriving Show

instance HashAlgorithm CryptoNightFast where
  hash = Hash . CryptoNightFast.hash

data CryptoNightSlow = CryptoNightSlow
                       deriving Show

instance HashAlgorithm CryptoNightSlow where
  hash = Hash . CryptoNightSlow.hash

data CryptoNightTree = CryptoNightTree
                       deriving Show

instance HashAlgorithm CryptoNightTree where
  hash = Hash . CryptoNightTree.hash

type Id     = CryptoNightFast
type PoW    = CryptoNightSlow
type Merkle = CryptoNightTree
