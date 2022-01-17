{-# LANGUAGE OverloadedStrings #-}

module Sidemash.Http where
  import Data.Aeson
  import Sidemash.Auth
  import Sidemash.Sdk (version, host)
  import Sidemash.HttpRequest
  import Data.Digest.Pure.SHA
  import Data.Text.Encoding.Base64
  import qualified Data.Text as T
  import qualified Data.ByteString.Lazy as LB
  import qualified Data.ByteString as B
  import qualified Data.ByteString.Lazy.Char8 as C
  import Data.Text.Encoding
  import qualified Data.CaseInsensitive as CI
  import Network.HTTP.Simple
  import Control.Exception

  data HttpCallException = HttpCallException String deriving Show
  instance Exception HttpCallException


  sign :: T.Text -> T.Text -> T.Text
  sign message secretKey =
    let m = C.pack $ T.unpack message
        p = C.pack $ T.unpack secretKey
    in encodeBase64 $ T.pack $ C.unpack $ bytestringDigest $ hmacSha512 p m

  hash :: LB.ByteString -> T.Text
  hash message =
    let m = message -- C.pack $ T.unpack message
    in encodeBase64 $ T.pack $ C.unpack $ bytestringDigest $ sha256 m

  computeSignedHeaders :: Maybe LB.ByteString -> [(T.Text, T.Text)] -> Auth -> [(T.Text, T.Text)]
  computeSignedHeaders body headers auth =
    headers ++ additionalHeaders ++ (headerForContent body)
    where
      additionalHeaders = [("Accept", "application/json"), ("User-Agent", "Sdk Haskell " <> version), ("Authorization", "Bearer " <> (token auth))]
      headerForContent (Just _) = [("Content-Type", "application/json")]
      headerForContent Nothing = []

  get :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  get path headers queryString converter auth        = call "GET" path headers queryString Nothing converter auth

  list :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  list path headers queryString converter auth       = call "GET" path headers queryString Nothing converter auth

  post :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> Maybe LB.ByteString -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  post path headers queryString body converter auth  = call "POST" path headers queryString body converter auth

  patch :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> Maybe LB.ByteString -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  patch path headers queryString body converter auth = call "PATCH"  path headers queryString body converter auth

  put :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> Maybe LB.ByteString -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  put path headers queryString body converter auth   = call "PUT"    path headers queryString body converter auth

  delete :: T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> Maybe LB.ByteString -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  delete path headers queryString body converter auth = call "DELETE" path headers queryString body converter auth

  call :: T.Text -> T.Text -> [(T.Text, T.Text)] -> [(T.Text, T.Text)] -> Maybe LB.ByteString -> (LB.ByteString -> Maybe a) -> Auth -> IO a
  call method path headers queryString body converter auth =
       let computedSignedHeaders = computeSignedHeaders body headers auth
           bodyHash = fmap hash body
       in do
           sdmRequest <- createHttpRequest computedSignedHeaders method path queryString bodyHash
           let allHeaders = computedSignedHeaders ++ [
                            ("X-Sdm-Nonce", T.pack $ show $ nonce sdmRequest),
                            ("X-Sdm-SignedHeaders", T.intercalate  ", " $ fmap (\h -> fst h) $ signedHeaders sdmRequest),
                            ("X-Sdm-Signature", T.pack "SHA512 " <> (sign (toMessage sdmRequest) (secretKey auth)) )]
               initialRequest = case body of
                    (Just b) -> setRequestBodyLBS b defaultRequest
                    Nothing -> defaultRequest
               request =
                  setRequestHost (encodeUtf8 host)
                  $ setRequestPath (encodeUtf8 path)
                  $ setRequestMethod (encodeUtf8 method)
                  $ setRequestHeaders (fmap (\q -> (CI.mk $ encodeUtf8 $ fst q, encodeUtf8 $ snd q)) allHeaders)
                  $ setRequestQueryString (fmap (\q -> (encodeUtf8 $ fst q, Just $ encodeUtf8 $ snd q)) queryString)
                  $ initialRequest
           response <- httpLBS request
           case converter $ getResponseBody response of
              (Just r) -> return r
              Nothing  -> throw $ HttpCallException "An error occured while calling Sidemash API"
