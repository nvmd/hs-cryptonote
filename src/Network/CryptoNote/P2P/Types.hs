module Network.CryptoNote.P2P.Types where

import Data.Word (Word64)

import qualified Network.Levin.Message as Levin
import Network.CryptoNote.Crypto.Hash (Hash, Id)

import Network.CryptoNote.P2P.Notify.NewBlock (NotifyNewBlock)
import Network.CryptoNote.P2P.Notify.NewTransactions (NotifyNewTransactions)
import Network.CryptoNote.P2P.Command.GetObjects.Request (RequestGetObjects)
import Network.CryptoNote.P2P.Command.GetObjects.Response (ResponseGetObjects)
import Network.CryptoNote.P2P.Command.Chain.Request (RequestChain)
import Network.CryptoNote.P2P.Command.Chain.Response (ResponseChainEntry)


-- cryptonote_protocol_handler.h
-- cryptonote_protocol_defs.h

type P2PProtocolMessage      = Levin.Message CoreSyncData CoreSyncData CoreStatInfo
type CurrencyProtocolMessage = Message

data Message = MNotifyNewBlock NotifyNewBlock
             | MNotifyNewTx    NotifyNewTransactions
             | MReqGetObjects  RequestGetObjects
             | MRespGetObjects ResponseGetObjects
             | MReqChain       RequestChain
             | MRespChainEntry ResponseChainEntry
             deriving (Show, Eq)


data ConnectionInfo = ConnectionInfo
    { incoming :: Bool
    , ip       :: String
    , port     :: String
    , peerId   :: String
    } deriving (Show, Eq)


data CoreSyncData = CoreSyncData
    { currentHeight :: Word64
    , topId         :: Hash Id
    } deriving (Show, Eq)


data CoreStatInfo = CoreStatInfo
    { txPoolSize        :: Word64
    , blockchainHeight  :: Word64
    , miningSpeed       :: Word64
    , alternativeBlocks :: Word64
    , topBlockId        :: String
    } deriving (Show, Eq)
