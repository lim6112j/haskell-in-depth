module DirTree where

import AppTypes
import Control.Monad.RWS
import System.FilePath (takeBaseName)
import System.PosixCompat (isDirectory)
import Utils

dirTree :: MyApp (FilePath, Int) s ()
dirTree = do
  AppEnv {..} <- ask
  fs <- currentPathStatus
  when (isDirectory fs && depth <= maxDepth cfg) $ do
    tell [(takeBaseName path, depth)]
    traverseDirectoryWith dirTree
