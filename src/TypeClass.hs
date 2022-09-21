--

module TypeClass where

data Direction = North | East | South | West deriving (Eq, Enum, Bounded, Show)

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

instance CyclicEnum Direction

rotate :: Turn -> Direction -> Direction
rotate TNone = id
rotate TLeft = cpred
rotate TRight = csucc
rotate TAround = cpred . cpred
