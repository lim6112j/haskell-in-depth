{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}

module TypeClass where

import Fmt (Buildable, build, fmt, fmtLn, nameF, unwordsF, (+||), (||+))

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

instance Semigroup Turn where
  TNone <> t = t
  TLeft <> TLeft = TAround
  TLeft <> TRight = TNone
  TLeft <> TAround = TRight
  TRight <> TRight = TAround
  TRight <> TAround = TLeft
  TAround <> TAround = TNone
  t1 <> t2 = t2 <> t1

instance Monoid Turn where
  mempty = TNone

-- now Turn is monoid
rotateMany' :: Direction -> [Turn] -> Direction
rotateMany' d ts = rotate (mconcat ts) d

-- file
deriving instance Read Direction

deriving instance Read Turn

-- for using fmt package , reporting

instance Buildable Direction where
  build North = "N"
  build East = "E"
  build West = "W"
  build South = "S"

instance Buildable Turn where
  build TNone = "--"
  build TRight = "->"
  build TLeft = "<-"
  build TAround = "||"

rotateFromFile :: Direction -> FilePath -> IO ()
rotateFromFile dir fname = do
  f <- readFile fname
  let turns = map read $ lines f
      finalDir = rotateMany dir turns
      dirs = rotateManyStep dir turns
  fmtLn $ "Final Direction: " +|| finalDir ||+ ""
  fmt $ nameF "Intermediate directions" (unwordsF dirs)

-- orientFromFile :: FilePath -> IO ()
