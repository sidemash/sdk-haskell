{-# LANGUAGE OverloadedStrings #-}

module Main where

import Sidemash.Auth
import Sidemash.Client
import Sidemash.CreateDomainForm
import Sidemash.Service
import Sidemash.Http
import Sidemash.Domain (Purpose(..))
import Data.Aeson (encode, decode)


main :: IO ()
main =
    let auth = Auth{token = "1234", secretKey = "****"}
        sdm  = Client{auth = auth}
        form = CreateDomainForm { name = "haksell.org", purpose = Play, description = Nothing, foreignData = Nothing }
    in do
    --domain <- sdm `createDomain` form
    -- putStrLn (show domain)
    putStrLn (show "domain")

