{-# LANGUAGE CPP #-}

module Network.Levin.Message where

import Data.Binary (Binary)

import Network.Levin.Command.Handshake (CommandHandshake)
import Network.Levin.Command.Ping (CommandPing)
import Network.Levin.Command.TimedSync (CommandTimedSync)
import Network.Levin.Command.Debug


-- net_node.h
-- p2p_protocol_defs.h

data (Binary hp, Binary tp, Binary si) =>
     Message hp tp si = MHandshake       (CommandHandshake hp)
                      | MTimedSync       (CommandTimedSync tp)
                      | MPing            CommandPing
                      | MReqStatInfo     (CommandRequestStatInfo si) -- ^ Debug command.
                      | MReqNetworkState CommandRequestNetworkState  -- ^ Debug command.
                      | MReqPeerId       CommandRequestPeerId        -- ^ Debug command.
                      deriving (Show, Eq)
