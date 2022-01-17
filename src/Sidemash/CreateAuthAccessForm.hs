{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.CreateAuthAccessForm where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   data CreateAuthAccessForm = CreateAuthAccessForm { requireSignature :: Bool,
                                                      description :: Maybe Text,
                                                      foreignData :: Maybe Text } deriving (Generic, Show, Eq)
   instance ToJSON CreateAuthAccessForm where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }

   instance FromJSON CreateAuthAccessForm
