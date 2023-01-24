{-# LANGUAGE DeriveAnyClass #-}
import Control.Exception
import Control.Monad.Catch hiding (try)
import Data.Functor
data MyArithException = DivByZero | OtherArithException deriving (Show, Exception)
divPure :: Int -> Int -> Int
divPure _ 0 = throw DivByZero
divPure x y = x `div` y

divIO :: Int -> Int -> IO Int
divIO _ 0 = throwIO DivByZero
divIO x y = pure (x `div` y)

divM :: MonadThrow m => Int -> Int -> m Int
divM _ 0 = throwM DivByZero
divM x y = pure (x `div` y)
testComputation :: Int -> Int -> Int -> IO Int
testComputation a b c = divIO a b >>= divIO c

divTestWithRecovery :: Int -> Int -> Int -> IO Int
divTestWithRecovery a b c =
  try (testComputation a b c) <&> dealWith
    where
      dealWith :: Either MyArithException Int -> Int
      dealWith (Right r) = r
      dealWith (Left _) = 0
main :: IO ()
main = do
  3 `divM` 1 >>= print
  3 `divIO` 2 >>= print
  divTestWithRecovery 10 10 0 >>= print
  print $ 3 `divPure` 0
