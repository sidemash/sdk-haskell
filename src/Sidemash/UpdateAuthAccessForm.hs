{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.UpdateAuthAccessForm where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   data UpdateAuthAccessForm = UpdateAuthAccessForm { id :: Text } deriving (Generic, Show, Eq)
   instance ToJSON UpdateAuthAccessForm where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }

   instance FromJSON UpdateAuthAccessForm
