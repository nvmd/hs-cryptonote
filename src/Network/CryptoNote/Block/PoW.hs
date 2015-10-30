module Network.CryptoNote.Block.PoW ( pow
                                    ) where

import Network.CryptoNote.Block.Types (Block (..), hashingBlob)
import Network.CryptoNote.Crypto.Types (Hash)
import Network.CryptoNote.Crypto.Hash (cryptoNightSlow, tree)
import qualified Network.CryptoNote.Identifiable as Id

import Data.Binary (encode)
import Data.ByteString.Lazy (toStrict)


-- cryptonote_core/cryptonote_format_utils.cpp

-- get_block_hash
pow :: Block -> Hash
pow = cryptoNightSlow . toStrict . hashingBlob
