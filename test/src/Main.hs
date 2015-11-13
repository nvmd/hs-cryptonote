{-# LANGUAGE OverloadedStrings #-}

module Main where

import Test.Framework
import Test.Framework.Providers.HUnit
import Test.Framework.Providers.QuickCheck2
import Test.HUnit
import Test.QuickCheck

import Data.ByteString
import qualified Data.ByteString.Lazy as BL (toStrict, fromStrict)

import Network.CryptoNote.Transaction as Transaction
import Network.CryptoNote.Identifiable as Identifiable
import Network.CryptoNote.Crypto.Hash as Hash

import qualified Data.Binary as BIN (encode, decode)
import qualified Data.Aeson as JSON (encode, decode)

import qualified TestData as D

main :: IO ()
main = defaultMain tests


tests = hUnitTestToTests $ test [
  "entityDecode_BytesToEntity" ~: decodeBytesToEntity,
  "entityId_OnEntities"        ~: entityId,
  "cnFastHash_OnRawBytes"      ~: cnFastHash,
  "jsonEncode"                 ~: jsonEncode
  ]

decodeBytesToEntity = test
  [ "Tx0" ~:
     D.txBodyEntity 0
     ~=? (BIN.decode $ BL.fromStrict $ D.txBodyBytes 0 :: Transaction)
  ]

entityId = test
  [ "Tx0 Id" ~:
     (BIN.decode $ BL.fromStrict $ D.txIdBytes 0 :: Hash Id)
     ~=? (Identifiable.id $ D.txBodyEntity 0 :: Hash Id)
  ]

cnFastHash = test
  [ "Tx0 Id" ~:
     D.txIdBytes 0
     ~=? (BL.toStrict $ BIN.encode $ Hash.cryptoNightFast $ D.txBodyBytes 0)
  ]

jsonEncode = test
  [ "Empty Tx" ~:
    "{\"version\":0,\"unlockTime\":0,\"inputs\":[],\"outputs\":[],\"extra\":[],\"signatures\":[]}"
    ~=? (JSON.encode $ D.txBodyEntity 0)
  ]
