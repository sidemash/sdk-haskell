{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Domain where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.UTCDateTime


   data Purpose = Play | Publish deriving (Generic, Show, Eq)
   instance ToJSON Purpose where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Purpose

   data Status = Preparing | Ready deriving (Generic, Show, Eq)
   instance ToJSON Status where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Status

   data Domain = Domain { id :: Text,
                          url :: Text,
                          createdTime :: UTCDateTime,
                          name :: Text,
                          status :: Status,
                          purpose :: Purpose,
                          description :: Maybe Text,
                          foreignData :: Maybe Text } deriving (Generic, Show, Eq)
   instance ToJSON Domain where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Domain
