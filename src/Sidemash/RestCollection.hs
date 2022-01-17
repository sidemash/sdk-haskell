{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.RestCollection where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   import Sidemash.Pagination


   data RestCollection a = RestCollection { url :: Text,
                                            pagination :: Pagination,
                                            items :: [a] } deriving (Generic, Show, Eq)
   instance ToJSON a => ToJSON (RestCollection a) where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
   instance FromJSON a => FromJSON (RestCollection a)
