{-# LANGUAGE DeriveGeneric #-}

module Network.Levin.LowLevel where

import Data.Binary
import GHC.Generics (Generic)

import Data.ByteString as B (ByteString, length)
import Data.Bits ((.|.), (.&.))
import qualified Data.ByteString.Lazy as BL


-- levin_base.h

-- #define LEVIN_DEFAULT_TIMEOUT_PRECONFIGURED 0  -- invoke timeout (timeout until peer's response)
-- #define LEVIN_DEFAULT_MAX_PACKET_SIZE 100000000      //100MB by default

-- #define LEVIN_OK                                        0
-- #define LEVIN_ERROR_CONNECTION                         -1
-- #define LEVIN_ERROR_CONNECTION_NOT_FOUND               -2
-- #define LEVIN_ERROR_CONNECTION_DESTROYED               -3
-- #define LEVIN_ERROR_CONNECTION_TIMEDOUT                -4
-- #define LEVIN_ERROR_CONNECTION_NO_DUPLEX_PROTOCOL      -5
-- #define LEVIN_ERROR_CONNECTION_HANDLER_NOT_DEFINED     -6
-- #define LEVIN_ERROR_FORMAT                             -7


data Flag = PacketRequest | PacketResponse
          deriving (Eq, Show)

-- bucket_head2 – seems to be used in async (levin_protocol_handler_async.h), bucket_head in sync (levin_protocol_handler.h)
data Header = Header { magic            :: Word64 -- signature
                     , payloadLength    :: Word64 -- cb
                     , haveToReturnData :: Bool   -- r?
                     , command          :: Word32 -- cmd
                     , returnCode       :: Word32
                     , flags            :: Word32 -- flags
                     , protocolVersion  :: Word32 -- ver
                     } deriving (Show, Eq, Generic)


--

data Packet = Packet { header  :: Header
                     , payload :: ByteString  -- length(payload) == header.payloadLength
                     } deriving (Show, Eq, Generic)

instance Binary Header

instance Binary Packet


--

defaultHeader :: Header
defaultHeader = Header { magic = 0x0101010101012101 -- Bender's nightmare
                       , payloadLength = 0
                       , haveToReturnData = False
                       , command = 0
                       , returnCode = 0
                       , flags = 0
                       , protocolVersion = 1
                       }

makePacket :: Binary p => Header ->
                          Bool -> Word32 -> Word32 ->
                          [Flag] -> p -> Packet
makePacket h h2r c r fs p = Packet (h { payloadLength = fromIntegral $ B.length payload
                                      , haveToReturnData = h2r
                                      , command          = c
                                      , returnCode       = r
                                      , flags            = encodeFlags fs
                                      })
                            payload
                 where payload     = BL.toStrict $ encode p
                       encodeFlags = foldr (.|.) 0 . map encodeFlag

checkFlag :: Word32 -> Flag -> Bool
checkFlag fs qf = (fs .&. qfe) == qfe
                where qfe = encodeFlag qf

encodeFlag :: Flag -> Word32
encodeFlag PacketRequest  = 0x00000001
encodeFlag PacketResponse = 0x00000002
