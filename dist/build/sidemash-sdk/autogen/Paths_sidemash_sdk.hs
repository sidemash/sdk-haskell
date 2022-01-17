{-# LANGUAGE CPP #-}
{-# LANGUAGE NoRebindableSyntax #-}
{-# OPTIONS_GHC -fno-warn-missing-import-lists #-}
module Paths_sidemash_sdk (
    version,
    getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir,
    getDataFileName, getSysconfDir
  ) where

import qualified Control.Exception as Exception
import Data.Version (Version(..))
import System.Environment (getEnv)
import Prelude

#if defined(VERSION_base)

#if MIN_VERSION_base(4,0,0)
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#else
catchIO :: IO a -> (Exception.Exception -> IO a) -> IO a
#endif

#else
catchIO :: IO a -> (Exception.IOException -> IO a) -> IO a
#endif
catchIO = Exception.catch

version :: Version
version = Version [0,1,0,0] []
bindir, libdir, dynlibdir, datadir, libexecdir, sysconfdir :: FilePath

bindir     = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\bin"
libdir     = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.3\\sidemash-sdk-0.1.0.0-AstQeYpcv2RDEIz7YUn0kb-sidemash-sdk"
dynlibdir  = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.3"
datadir    = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\x86_64-windows-ghc-8.6.3\\sidemash-sdk-0.1.0.0"
libexecdir = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\sidemash-sdk-0.1.0.0-AstQeYpcv2RDEIz7YUn0kb-sidemash-sdk\\x86_64-windows-ghc-8.6.3\\sidemash-sdk-0.1.0.0"
sysconfdir = "C:\\Users\\Kablan\\AppData\\Roaming\\cabal\\etc"

getBinDir, getLibDir, getDynLibDir, getDataDir, getLibexecDir, getSysconfDir :: IO FilePath
getBinDir = catchIO (getEnv "sidemash_sdk_bindir") (\_ -> return bindir)
getLibDir = catchIO (getEnv "sidemash_sdk_libdir") (\_ -> return libdir)
getDynLibDir = catchIO (getEnv "sidemash_sdk_dynlibdir") (\_ -> return dynlibdir)
getDataDir = catchIO (getEnv "sidemash_sdk_datadir") (\_ -> return datadir)
getLibexecDir = catchIO (getEnv "sidemash_sdk_libexecdir") (\_ -> return libexecdir)
getSysconfDir = catchIO (getEnv "sidemash_sdk_sysconfdir") (\_ -> return sysconfdir)

getDataFileName :: FilePath -> IO FilePath
getDataFileName name = do
  dir <- getDataDir
  return (dir ++ "\\" ++ name)
