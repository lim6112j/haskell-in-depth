{-# OPTIONS_GHC -Wno-type-defaults #-}

module DiffList where

import Control.Monad.Writer (MonadWriter (tell), Writer, runWriter)

newtype DiffList a = DiffList {getDiffList :: [a] -> [a]}

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs ++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Semigroup (DiffList a) where
  (DiffList f) <> (DiffList g) = DiffList (f . g)

instance Monoid (DiffList a) where
  mempty = DiffList ([] ++)
  (DiffList f) `mappend` (DiffList g) = DiffList (f . g)

diffListFunc = do
  let list1 = [1, 2, 3]
  let list2 = [4, 5, 6]
  let toDiff = toDiffList list1
  let toDiff2 = toDiffList list2
  let concatDiff = toDiff `mappend` toDiff2
  let toList = fromDiffList concatDiff
  print toList

gcd' :: Int -> Int -> Writer (DiffList String) Int
gcd' a b
  | b == 0 = do
    tell (toDiffList ["Finished with " ++ show a])
    return a
  | otherwise = do
    result <- gcd' b (a `mod` b)
    tell (toDiffList [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)])
    return result

gcdFunc :: IO ()
gcdFunc = mapM_ putStrLn . fromDiffList . snd . runWriter $ gcd' 110 34
