{-
   Copyright © 2020 Sidemash Cloud Services

   Licensed under the Apache  License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless  required  by  applicable  law  or  agreed to in writing,
   software  distributed  under  the  License  is distributed on an
   "AS IS"  BASIS, WITHOUT  WARRANTIES  OR CONDITIONS OF  ANY KIND,
   either  express  or  implied.  See the License for the  specific
   language governing permissions and limitations under the License.
-}


{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Pagination where
    import Data.Aeson
    import Data.Text (Text)
    import GHC.Generics
    import Sidemash.UTCDateTime


    data Pagination = Pagination { selfUrl :: Text, 
                                   prevUrl :: Maybe Text, 
                                   nextUrl :: Maybe Text, 
                                   startedTime :: UTCDateTime, 
                                   nbItemsOnThisPage :: Int, 
                                   page :: Int, 
                                   nbItemsPerPage :: Int }  deriving (Generic, Show, Eq)
    instance ToJSON Pagination where
        toEncoding = genericToEncoding defaultOptions { omitNothingFields = True }
    instance FromJSON Pagination