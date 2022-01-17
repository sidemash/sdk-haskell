{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.StreamInput where
   import Data.Aeson
   import GHC.Generics


   data StreamInput = StreamInput { seconds :: Int } deriving (Generic, Show, Eq)
   instance ToJSON StreamInput where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON StreamInput
