module IRC.Config where

import IRC.Proto
import Data.Configurator
import Data.Configurator.Types
import System.IO (Handle)
import Control.Monad.Reader (ReaderT)

type IRC = ReaderT Irc IO
data Irc = Irc { socket     :: Handle
               , listener   :: Message -> IRC ()
               , config     :: Config
               , serverName :: String
               }

loadConfig :: IO Config
loadConfig = load [Required "config.conf"]
