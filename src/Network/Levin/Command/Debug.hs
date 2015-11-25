module Network.Levin.Command.Debug where

import Network.Levin.Peer (PeerId)


-- net_node.h
-- p2p_protocol_defs.h


-- #ifdef ALLOW_DEBUG_COMMANDS
-- These commands are considered as insecure, and made in debug purposes for a limited lifetime.
-- Anyone who feel unsafe with this commands can disable the ALLOW_GET_STAT_COMMAND macro.

data CommandRequestStatInfo p = CommandRequestStatInfo
                              deriving (Show, Eq)

data CommandRequestNetworkState = CommandRequestNetworkState
                                deriving (Show, Eq)

data CommandRequestPeerId = CommandRequestPeerIdReq
                          | CommandRequestPeerIdResp
                            { peerId :: PeerId
                            }
                          deriving (Show, Eq)
