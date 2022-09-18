{-# OPTIONS_GHC -Wno-type-defaults #-}

module Lib
  ( someFunc,
  )
where

import Text.Read (readMaybe)

doubleStrNumber :: (Read a, Num a) => String -> Maybe a
doubleStrNumber str =
  case readMaybe str of
    Just x -> Just (2 * x)
    Nothing -> Nothing

printMaybe :: Show a => Maybe a -> String
printMaybe (Just a) = show a
printMaybe Nothing = "Nothing"

someFunc :: IO ()
someFunc = putStrLn $ printMaybe $ doubleStrNumber "3"
