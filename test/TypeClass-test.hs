{-# LANGUAGE StandaloneDeriving #-}
{-# OPTIONS_GHC -Wno-orphans #-}

import Control.Monad (replicateM)
import Control.Monad.Cont
import Data.List
import System.Exit (exitFailure)
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
  uniformM = uniformRM (minBound, maxBound)

deriving instance Ord Turn

uniformIO :: Uniform a => IO a
uniformIO = getStdRandom uniform

uniformsIO :: Uniform a => Int -> IO [a]
uniformsIO n = replicateM n uniformIO

randomTurns :: Int -> IO [Turn]
randomTurns = uniformsIO

randomDirections :: Int -> IO [Direction]
randomDirections = uniformsIO

randomWriteFile :: (Show a) => Int -> (Int -> IO [a]) -> FilePath -> IO ()
randomWriteFile n gen fname = do
  xs <- gen n
  writeFile fname $ unlines $ map show xs

test_allTurnsInUse :: Bool
test_allTurnsInUse =
  sort (nub [orient d1 d2 | d1 <- every, d2 <- every]) == every

test_rotationMonoidAgree :: [Turn] -> Bool
test_rotationMonoidAgree ts =
  and [rotateMany d ts == rotateMany' d ts | d <- every]

test_orientRotateAgree :: [Direction] -> Bool
test_orientRotateAgree [] = True
test_orientRotateAgree ds@(d : _) = ds == rotateManyStep d (orientMany ds)

main :: IO ()
main = do
  ds <- randomDirections 1000
  ts <- randomTurns 1000
  when
    (not $ and [test_allTurnsInUse, test_orientRotateAgree ds, test_rotationMonoidAgree ts])
    exitFailure
