module Sidemash.Client where
   import Sidemash.Auth
   data Client = Client { auth :: Auth } deriving (Read, Show, Eq)
