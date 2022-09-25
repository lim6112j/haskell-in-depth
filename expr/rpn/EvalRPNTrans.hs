module EvalRPNTrans where

import Control.Applicative (Alternative (empty))
import Control.Monad.State (StateT, evalStateT, get, gets, guard, lift, modify, put)
import Data.Foldable (traverse_)
import Text.Read (readMaybe)

type Stack = [Integer]

type EvalM = StateT Stack Maybe

push :: Integer -> EvalM ()
push x = modify (x :)

pop :: EvalM Integer
pop = do
  (x : xs) <- get
  put xs
  pure x

oneElementOnStack :: EvalM ()
oneElementOnStack = do
  l <- gets length
  guard (l == 1)

readSafe :: (Read s, Alternative f) => String -> f s
readSafe str = maybe empty pure (readMaybe str)

evalRPN :: String -> Maybe Integer
evalRPN str = evalStateT evalRPN' []
  where
    evalRPN' = traverse_ step (words str) >> oneElementOnStack >> pop
    step "+" = processTop (+)
    step "-" = processTop (-)
    step "*" = processTop (*)
    step t = readSafe t >>= push
    processTop op = flip op <$> pop <*> pop >>= push
