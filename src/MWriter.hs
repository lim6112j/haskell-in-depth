{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}

{-# HLINT ignore "Use camelCase" #-}

-- | gcdM
module MWriter (gcdM, gcd_logSteps, gcd_run) where

import Control.Monad.Writer

gcdM :: (Integral a, Monad m) => (a -> a -> m ()) -> a -> a -> m a
gcdM step a 0 = step a 0 >> pure a
gcdM step a b = step a b >> gcdM step b (a `mod` b)

gcd_logSteps :: Integral a => a -> a -> Writer [(a, a)] a
gcd_logSteps = gcdM (\a b -> tell [(a, b)])

gcd_run :: Integral a => a -> a -> (a, [(a, a)])
gcd_run a b = runWriter (gcd_logSteps a b)
