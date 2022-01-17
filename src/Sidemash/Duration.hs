{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Duration where
   import Data.Aeson
   import GHC.Generics


   data Duration = Duration { seconds :: Int } deriving (Generic, Show, Eq)
   instance ToJSON Duration where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON Duration
