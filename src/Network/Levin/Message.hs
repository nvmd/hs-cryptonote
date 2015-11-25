{-# LANGUAGE CPP #-}

module Network.Levin.Message where

import Data.Binary (Binary, get, put)
import Data.Binary.Get (getWord32le)
import Data.Binary.Put (putWord32le)

import Network.Levin.Command.Handshake (CommandHandshake)
import Network.Levin.Command.Ping (CommandPing)
import Network.Levin.Command.TimedSync (CommandTimedSync)
#if ENABLE_DEBUG_COMMANDS
import Network.Levin.Command.Debug
#endif


-- net_node.h
-- p2p_protocol_defs.h


data Message = MHandshake       (CommandHandshake ())
             | MTimedSync       (CommandTimedSync ())
             | MPing            CommandPing
#if ENABLE_DEBUG_COMMANDS
             | MReqStatInfo     (CommandRequestStatInfo ())      -- ^ Debug command.
             | MReqNetworkState CommandRequestNetworkState  -- ^ Debug command.
             | MReqPeerId       CommandRequestPeerId        -- ^ Debug command.
#endif
             deriving (Show, Eq)
