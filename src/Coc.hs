{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}

module Coc
    ( getData
    )
    where

import           Config
import           Control.Lens
import           Control.Monad
import           Data.Aeson
import qualified Data.ByteString      as BS
import qualified Data.ByteString.Lazy as BSL
import           GHC.Generics
import           Network.Wreq


url = "https://api.clashofclans.com/v1/players/%23Q9L9RR2U"

opts token = defaults & header "Accept" .~ ["application/json"]
                      & header "Authorization" .~ ["Bearer " <> token]

getData = do
    token <- getToken
    r <- getWith (opts token) url
    print $ r ^. responseBody
