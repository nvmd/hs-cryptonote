module Network.CryptoNote.Block.PoW ( pow
                                    ) where

import Network.CryptoNote.Block.Types (Block (..), hashingBlob)
import Network.CryptoNote.Crypto.Types (Hash)
import Network.CryptoNote.Crypto.Hash (cryptoNightSlow)

import Data.ByteString.Lazy (toStrict)


-- cryptonote_core/cryptonote_format_utils.cpp

-- get_block_hash
pow :: Block -> Hash
pow = cryptoNightSlow . toStrict . hashingBlob
