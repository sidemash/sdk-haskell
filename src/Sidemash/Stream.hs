{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Stream where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.Duration
   import Sidemash.MetaData
   import Sidemash.Photo
   import Sidemash.Play
   import Sidemash.StreamInput
   import Sidemash.UTCDateTime
   import Sidemash.UserDesc


   data Stream = Stream { id :: Text,
                          url :: Text,
                          input :: Maybe StreamInput,
                          foreignData :: Maybe Text,
                          description :: Maybe Text,
                          startedTime :: UTCDateTime,
                          availableOnDemand :: Bool,
                          initiator :: UserDesc,
                          metaData :: MetaData,
                          stoppedTime :: Maybe UTCDateTime,
                          duration :: Maybe Duration,
                          play :: Maybe Play,
                          poster :: Maybe Photo } deriving (Generic, Show, Eq)
   instance ToJSON Stream where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Stream
