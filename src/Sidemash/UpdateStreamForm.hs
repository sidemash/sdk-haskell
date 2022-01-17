{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.UpdateStreamForm where
   import Data.Aeson
   import Data.Text (Text)
   import GHC.Generics
   data UpdateStreamForm = UpdateStreamForm { id :: Text } deriving (Generic, Show, Eq)
   instance ToJSON UpdateStreamForm where
      toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }

   instance FromJSON UpdateStreamForm
