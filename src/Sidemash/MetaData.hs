{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.MetaData where
   import Data.Aeson
   import GHC.Generics


   data MetaData = MetaData { seconds :: Int } deriving (Generic, Show, Eq)
   instance ToJSON MetaData where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON MetaData
