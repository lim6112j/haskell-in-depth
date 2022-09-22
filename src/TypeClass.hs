{-# LANGUAGE DeriveAnyClass #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}

module TypeClass where

data Direction = North | East | South | West deriving (Eq, Enum, Bounded, Show, CyclicEnum)

data Turn = TNone | TLeft | TRight | TAround deriving (Eq, Enum, Bounded, Show)

class (Eq a, Enum a, Bounded a) => CyclicEnum a where
  cpred :: a -> a
  cpred d
    | d == minBound = maxBound
    | otherwise = pred d
  csucc :: a -> a
  csucc d
    | d == maxBound = minBound
    | otherwise = succ d

--instance CyclicEnum Direction

rotate :: Turn -> Direction -> Direction
rotate TNone = id
rotate TLeft = cpred
rotate TRight = csucc
rotate TAround = cpred . cpred

every :: (Enum a, Bounded a) => [a]
every = enumFrom minBound

orient :: Direction -> Direction -> Turn
orient d1 d2 = head $ filter (\t -> rotate t d1 == d2) every

rotateMany :: Direction -> [Turn] -> Direction
rotateMany = foldl (flip rotate)

rotateManyStep :: Direction -> [Turn] -> [Direction]
rotateManyStep = scanl $ flip rotate

orientMany :: [Direction] -> [Turn]
orientMany ds@(_ : _ : _) = zipWith orient ds (tail ds)
orientMany _ = []
