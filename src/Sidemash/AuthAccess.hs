{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.AuthAccess where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.UTCDateTime


   data AuthAccess = AuthAccess { id :: Text,
                                  url :: Text,
                                  createdTime :: UTCDateTime,
                                  requireSignature :: Bool,
                                  token :: Text,
                                  secretKey :: Text,
                                  description :: Maybe Text,
                                  foreignData :: Maybe Text } deriving (Generic, Show, Eq)
   instance ToJSON AuthAccess where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON AuthAccess
