{-# LANGUAGE ExistentialQuantification #-}

module Network.CryptoNote.Identifiable where

import Network.CryptoNote.Crypto.Types (Hash(..))

class Identifiable a where
  id :: a -> Hash
