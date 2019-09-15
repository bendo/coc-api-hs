{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Config
    ( loadConfig
    , getToken
    )
    where

import           Data.Aeson
import qualified Data.ByteString.Char8 as BS
import qualified Data.Yaml             as Y
import           GHC.Generics

data Config = Config { token :: String, ip :: String } deriving (Show, Generic)
instance FromJSON Config

-- | load config file
loadConfig :: IO (Maybe Config)
loadConfig = do
    let file = "/home/bendo/.coc-config.yaml"
    content <- BS.readFile file
    return $ Y.decodeThrow content :: IO (Maybe Config)

-- | get token from config file
getToken :: IO BS.ByteString
getToken = do
    c <- loadConfig
    case c of
        Nothing                 -> error "Could not parse config file."
        (Just (Config token _)) -> return (BS.pack token)
