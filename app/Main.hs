module Main (main) where

import Contexts
import DiffList
import GenSQL
import Lib (someFunc4)
import MState
import MWriter
--import Numeric
import System.Environment (getArgs)
import TypeClass

main :: IO ()
--main = testSQL
--main = gcdFunc 11001 34117
main = do
  args <- getArgs
  case args of
    ["-r", fname, dir] -> rotateFromFile (read dir) fname
    ["-o", fname] -> orientFromFile fname
    _ -> putStrLn $ "Usage: locator -r filename direction"
