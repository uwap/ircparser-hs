module IRC.Logging where

import IRC.Types
import IRC.Config

import System.Directory
import System.FilePath

import Control.Monad
import Control.Monad.Reader

logFile :: String -> IRC (Maybe FilePath)
logFile chan = do
    serverLogPath <- lookupServerConfig "logs"
    let filePath = serverLogPath >>= \path -> return (path </> chan <.> "log")
    case filePath of
      Just path -> liftIO $ liftM (fromBool path) $ doesFileExist path
      Nothing -> return Nothing
  where
    fromBool a True  = Just a
    fromBool _ False = Nothing