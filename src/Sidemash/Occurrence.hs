{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Occurrence where
   import Data.Aeson
   import GHC.Generics


   data Occurrence = Occurrence { seconds :: Int } deriving (Generic, Show, Eq)
   instance ToJSON Occurrence where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Occurrence
