{-# OPTIONS_GHC -Wno-incomplete-patterns #-}
{-# OPTIONS_GHC -Wno-type-defaults #-}

module Lib
  ( someFunc,
    someFunc2,
    someFunc3,
  )
where

import System.Posix.Internals (lstat)
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

type Name = String

type Phone = String

type Location = String

type PhoneNumbers = [(Name, Phone)]

type Locations = [(Phone, Location)]

lookup' :: Eq a => a -> [(a, b)] -> Maybe b
lookup' a ((x, y) : xs)
  | null xs = Nothing
  | a == x = Just y
  | otherwise = lookup' a xs

locateByName :: PhoneNumbers -> Locations -> Name -> Maybe Location
locateByName ps ls s = lookup s ps >>= flip lookup' ls

locateByName' ps ls s =
  case lookup' s ps of
    Just number -> lookup' number ls
    Nothing -> Nothing

locations :: Locations
locations = [("1", "seoul"), ("2", "bussan")]

phones :: PhoneNumbers
phones = [("kim", "1"), ("kwon", "2"), ("jane", "3")]

someFunc :: IO ()
-- someFunc = putStrLn $ printMaybe $ doubleStrNumber "3"

-- somefunc = print $ doubleStrNumber "3"
someFunc = print $ doubleStrNumber2 "3"

someFunc2 :: IO ()
someFunc2 = print $ plusStrNumbers "3" "4"

someFunc3 = print $ locateByName phones locations "kim"
