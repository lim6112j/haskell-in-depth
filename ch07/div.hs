{-# LANGUAGE DeriveAnyClass #-}
import Control.Exception
import Control.Monad.Catch
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
main :: IO ()
main = do
  3 `divM` 1 >>= print
  3 `divIO` 2 >>= print
  print $ 3 `divPure` 0
