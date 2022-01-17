{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.UpdateDomainForm where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   data UpdateDomainForm = UpdateDomainForm { id :: Text } deriving (Generic, Show, Eq)
   instance ToJSON UpdateDomainForm where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }

   instance FromJSON UpdateDomainForm
