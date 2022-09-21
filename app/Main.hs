module Main (main) where

import DiffList
import GenSQL
import Lib (someFunc4)
import MState
import MWriter
import TypeClass

main :: IO ()
--main = testSQL
main = gcdFunc 11001 34117
