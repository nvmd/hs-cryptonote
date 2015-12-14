{-# LANGUAGE CPP #-}

module Network.Levin.Message (Message) where

import Data.Binary (Binary)

import Network.Levin.Command.Handshake (CommandHandshake)
import Network.Levin.Command.Ping (CommandPing)
import Network.Levin.Command.TimedSync (CommandTimedSync)
import Network.Levin.Command.Debug


-- net_node.h
-- p2p_protocol_defs.h

data (Binary hp, Binary tp, Binary si) =>
     LevinMessage hp tp si = LMHandshake       (CommandHandshake hp)
                           | LMTimedSync       (CommandTimedSync tp)
                           | LMPing            CommandPing
                           | LMReqStatInfo     (CommandRequestStatInfo si) -- ^ Debug command.
                           | LMReqNetworkState CommandRequestNetworkState  -- ^ Debug command.
                           | LMReqPeerId       CommandRequestPeerId        -- ^ Debug command.
                           deriving (Show, Eq)

data (Binary hp, Binary tp, Binary si, Binary a) =>
     Message hp tp si a = P2P (LevinMessage hp tp si)
                        | Application a
                        deriving (Show, Eq)
