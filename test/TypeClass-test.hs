{-# OPTIONS_GHC -Wno-orphans #-}

import Control.Monad (replicateM)
import System.Random
import System.Random.Stateful (uniformM, uniformRM)
import TypeClass

instance UniformRange Turn where
  uniformRM (lo, hi) rng = do
    res <- uniformRM (fromEnum lo :: Int, fromEnum hi) rng
    pure $ toEnum res

instance Uniform Turn where
  uniformM = uniformRM (minBound, maxBound)

instance UniformRange Direction where
  uniformRM (lo, hi) rng = do
    res <- uniformRM (fromEnum lo :: Int, fromEnum hi) rng
    pure $ toEnum res

instance Uniform Direction where
  uniformM rng = uniformRM (minBound, maxBound) rng

uniformIO :: Uniform a => IO a
uniformIO = getStdRandom uniform

uniformsIO :: Uniform a => Int -> IO [a]
uniformsIO n = replicateM n uniformIO

randomTurns :: Int -> IO [Turn]
randomTurns = uniformsIO

randomDirections :: Int -> IO [Direction]
randomDirections = uniformsIO

main :: IO ()
main = do
  xs <- randomDirections 10
