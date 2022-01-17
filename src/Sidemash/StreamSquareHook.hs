{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.StreamSquareHook where
   import Data.Aeson
   import GHC.Generics


   data StreamSquareHook = HttCall { seconds :: Int } | OtherHook deriving (Generic, Show, Eq)
   instance ToJSON StreamSquareHook where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON StreamSquareHook
