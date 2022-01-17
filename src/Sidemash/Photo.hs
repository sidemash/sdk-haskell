{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Photo where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.UTCDateTime


   data Photo = Photo { id :: Text,
                        url :: Text,
                        createdTime :: UTCDateTime,
                        src :: Text,
                        name :: Text } deriving (Generic, Show, Eq)
   instance ToJSON Photo where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Photo
