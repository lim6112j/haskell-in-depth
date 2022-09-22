module Main (main) where

import DiffList
import GenSQL
import Lib (someFunc4)
import MState
import MWriter
import System.Environment (getArgs)
import TypeClass

main :: IO ()
--main = testSQL
--main = gcdFunc 11001 34117
main = do
  args <- getArgs
  case args of
    ["-r", fname, dir] -> rotateFromFile (read dir) (show fname)
    _ -> putStrLn $ "Usage: locator -r filename direction"
