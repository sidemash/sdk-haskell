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

module Sidemash.Service where
    import Data.Aeson
    import Data.Text (Text)
    import Sidemash.Client
    import Sidemash.CreateStreamSquareForm
    import Sidemash.Http
    import Sidemash.ListForm
    import Sidemash.RestCollection
    import Sidemash.Sdk (version)
    import Sidemash.StreamSquare
    import qualified Sidemash.UpdateStreamSquareForm as Sdm.UpdateStreamSquareForm

    createStreamSquare :: Client -> CreateStreamSquareForm -> IO StreamSquare
    createStreamSquare sdm form =
        let converter = \result -> decode(result) :: Maybe StreamSquare
        in post ("/" <> version <> "/stream-squares") [] [] (Just $ encode form) converter (auth sdm)

    deleteStreamSquare :: Client -> Text -> IO ()
    deleteStreamSquare sdm id =
        let converter = \ignored -> Just ()
        in delete ("/" <> version <> "/stream-squares/" <> id) [] [] Nothing converter (auth sdm)

    getStreamSquare :: Client -> Text -> IO StreamSquare
    getStreamSquare sdm id =
        let converter = \result -> decode(result) :: Maybe StreamSquare
        in get ("/" <> version <> "/stream-squares/" <> id) [] [] converter (auth sdm)

    listStreamSquare :: Client -> Maybe ListForm -> IO (RestCollection StreamSquare)
    listStreamSquare sdm maybeForm =
        let converter = \result -> decode(result) :: Maybe (RestCollection StreamSquare)
        in list ("/" <> version <> "/stream-squares") [] (toQueryString maybeForm) converter (auth sdm)

    updateStreamSquare :: Client -> Sdm.UpdateStreamSquareForm.UpdateStreamSquareForm -> IO StreamSquare
    updateStreamSquare sdm form =
        let converter = \result -> decode(result) :: Maybe StreamSquare
            id = Sdm.UpdateStreamSquareForm.id form
            body = Sdm.UpdateStreamSquareForm.body form
        in patch ("/" <> version <> "/stream-squares/" <> id) [] [] (Just $ encode body) converter (auth sdm)
