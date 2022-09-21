{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use camelCase" #-}

-- | gcdM
module MWriter where

import Control.Monad.Writer

-- using plain function : step e.g. print (a,b)
gcdM :: (Integral a, Monad m) => (a -> a -> m ()) -> a -> a -> m a
gcdM step a 0 = step a 0 >> pure a
gcdM step a b = step a b >> gcdM step b (a `mod` b)

-- log arraay of pair
gcd_logSteps :: Integral a => a -> a -> Writer [(a, a)] a
gcd_logSteps = gcdM (\a b -> tell [(a, b)])

-- counting step
gcd_countSteps :: Integral a => a -> a -> Writer (Sum Int) a
gcd_countSteps = gcdM (\_ _ -> tell $ Sum 1)

-- using mapWriter
gcd_countSteps' :: Integral b => b -> b -> Writer (Sum Int) b
gcd_countSteps' a b = mapWriter mapper (gcd_logSteps a b)
  where
    mapper (v, w) = (v, Sum $ length w)

-- simplify
gcd_countSteps'' :: Integral a => a -> a -> Writer (Sum Int) a
gcd_countSteps'' = (mapWriter (Sum . length <$>) .) . gcd_logSteps
