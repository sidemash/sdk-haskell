{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.CreateDomainForm where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.Domain
   data CreateDomainForm = CreateDomainForm { name :: Text,
                                              purpose :: Purpose,
                                              description :: Maybe Text,
                                              foreignData :: Maybe Text } deriving (Generic, Show, Eq)
   instance ToJSON CreateDomainForm where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }

   instance FromJSON CreateDomainForm
