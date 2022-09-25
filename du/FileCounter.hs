module FileCounter where

import AppTypes
import Control.Monad.RWS
import System.Directory.Extra (listFiles)
import System.FilePath
import System.PosixCompat (isDirectory)
import Utils (currentPathStatus, traverseDirectoryWith)

checkExtension :: AppConfig -> FilePath -> Bool
checkExtension cfg fp = do
  maybe True (`isExtensionOf` fp) (extension cfg)

fileCount :: MyApp (FilePath, Int) s ()
fileCount = do
  AppEnv {..} <- ask
  fs <- currentPathStatus
  when (isDirectory fs && depth <= maxDepth cfg) $ do
    traverseDirectoryWith fileCount
    files <- liftIO $ listFiles path
    tell [(path, length $ filter (checkExtension cfg) files)]
