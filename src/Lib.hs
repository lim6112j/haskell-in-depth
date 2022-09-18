{-# OPTIONS_GHC -Wno-type-defaults #-}

module Lib
  ( someFunc,
    someFunc2,
  )
where

import Text.Read (readMaybe)

doubleStrNumber :: (Read a, Num a) => String -> Maybe a
doubleStrNumber str =
  case readMaybe str of
    Just x -> Just (2 * x)
    Nothing -> Nothing

doubleStrNumber2 :: (Num b, Read b) => String -> Maybe b
doubleStrNumber2 str = (* 2) `fmap` readMaybe str

plusStrNumbers :: (Num b, Read b) => String -> String -> Maybe b
plusStrNumbers s1 s2 = (+) <$> readMaybe s1 <*> readMaybe s2

printMaybe :: Show a => Maybe a -> String
printMaybe (Just a) = show a
printMaybe Nothing = "Nothing"

someFunc :: IO ()
-- someFunc = putStrLn $ printMaybe $ doubleStrNumber "3"

-- somefunc = print $ doubleStrNumber "3"
someFunc = print $ doubleStrNumber2 "3"

someFunc2 :: IO ()
someFunc2 = print $ plusStrNumbers "3" "4"
