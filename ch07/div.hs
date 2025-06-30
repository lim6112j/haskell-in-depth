{-# LANGUAGE DeriveAnyClass #-}
import Control.Exception
import Control.Monad.Catch hiding (catch, tryJust, try)
import Data.Functor
import Control.Monad.Writer
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
testComputation a b c = do
  divIO a b >>= divIO c

testComputationWriter :: Int -> Int -> Int -> WriterT [Int] IO Int
testComputationWriter a b c = do
  o <- lift $ divIO a b
  tell [a, b, c, o]
  lift $ divIO c o
divTestWithRecovery :: Int -> Int -> Int -> IO Int
divTestWithRecovery a b c = do
  try (testComputation a b c ) <&> dealWith
    where
      dealWith :: Either MyArithException Int -> Int
      dealWith (Right r) =  r
      dealWith (Left _) = 0
divTestWithRecovery2 :: Int -> Int -> Int -> IO Int
divTestWithRecovery2 a b c =
  tryJust isDivideByZero (runWriterT $ testComputationWriter a b c) >>= pure . dealWith
  where
    dealWith (Right r) = fst r
    dealWith (Left _) = 0
    isDivideByZero :: MyArithException -> Maybe ()
    isDivideByZero DivByZero = Just ()
    isDivideByZero _ = Nothing
-- catch & handle
divTestIO :: Int -> Int -> Int -> IO Int
divTestIO a b c = testComputation a b c `catch` handler
  where
    handler :: MyArithException -> IO Int
    handler e = do
      putStrLn $ "We've got an exception: " ++ show e
        ++ "\nUsing default value 0"
      pure 0
main :: IO ()
main = do
  3 `divM` 1 >>= print -- no recovering below code will not run when exception
  3 `divIO` 2 >>= print -- no recovering below code will not run when exception
  print "divtest1"
  divTestWithRecovery 10 0 10 >>= print --  try recovered so below code run
  print "divtest2"
  divTestWithRecovery2 10 0 10 >>= print  -- tryJust recovered so below code run
  print "div catch exception"
  divTestIO 10 0 2 >>= print -- catch and handler , recovered so below code run
  print $ 4 `divPure` 2 -- pure division
--  print $ 3 `divPure` 0
