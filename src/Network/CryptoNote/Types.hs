module Network.CryptoNote.Types where

import Network.CryptoNote.Crypto.Types (PublicKey, SecretKey)


-- cryptonote_core/cryptonote_basic.h

data AccountPublicAddress = AccountPublicAddress {
  spendPubKey :: PublicKey,
  viewPubKey  :: PublicKey
} deriving (Eq, Show)

data KeyPair = KeyPair {
  public :: PublicKey,
  secret :: SecretKey
} deriving (Eq, Show)


-- cryptonote_core/account.h

data AccountKeys = AccountKeys {
  address     :: AccountPublicAddress,
  spendSecKey :: SecretKey,
  viewSecKey  :: SecretKey
} deriving (Eq, Show)
