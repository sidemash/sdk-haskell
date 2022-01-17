{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.StreamSquarePublish where
   import Data.Aeson
   import GHC.Generics

   data StreamSquarePublish = StreamSquarePublish { seconds :: Int } deriving (Generic, Show, Eq)
   instance ToJSON StreamSquarePublish where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON StreamSquarePublish
