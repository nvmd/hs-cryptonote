module Network.Levin.Peer where

import Data.Int (Int64)
import Data.Word (Word32, Word64)


type PeerId = Word64

data NetAddress = NetAddress
    { ip   :: Word32
    , port :: Word32
    } deriving (Show, Eq)

data Peer = Peer
    { adr      :: NetAddress
    , id       :: PeerId
    , lastSeen :: Int64
    } deriving (Show, Eq)
