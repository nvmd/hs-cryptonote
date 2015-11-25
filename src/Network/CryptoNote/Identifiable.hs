{-# LANGUAGE ExistentialQuantification #-}

module Network.CryptoNote.Identifiable where

import Network.CryptoNote.Crypto.Hash (Hash, Id)

class Identifiable a where
  id :: a -> Hash Id
