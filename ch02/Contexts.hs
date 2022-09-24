module Contexts where

import Control.Monad.Writer

readNumber :: IO Int
readNumber = do
  read <$> getLine

sumN :: Int -> Writer String Int
sumN 0 = writer (0, "finish")
sumN n = do
  tell (show n ++ ", ")
  s <- sumN (n - 1)
  pure (n + s)

cartesianProduct :: [Int] -> [Int] -> [(Int, Int)]
cartesianProduct xs ys = do
  x <- xs
  y <- ys
  pure (x, y)

-- foldable, traversable
addNumber :: Int -> IO String
addNumber n = pure (++) <*> pure (show n ++ " ") <*> getLine
