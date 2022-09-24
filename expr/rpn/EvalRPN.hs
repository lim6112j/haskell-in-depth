module EvalRPN where

import Control.Monad.State
import Data.Foldable (traverse_)

type Stack = [Integer]

type EvalM = State Stack

push :: Integer -> EvalM ()
push x = modify (x :)

pop :: EvalM Integer
pop = do
  xs <- get
  put (tail xs)
  pure (head xs)

evalRPN :: String -> Integer
evalRPN expr = evalState evalRPN' []
  where
    evalRPN' = traverse_ step (words expr) >> pop
    step "+" = processTops (+)
    step "*" = processTops (*)
    step "-" = processTops (-)
    step t = case readMaybe t of
      Just n -> push n
      Nothing -> undefined
    processTops op = flip op <$> pop <*> pop >>= push

isEmpty :: EvalM Bool
isEmpty = gets null

notEmpty :: EvalM Bool
notEmpty = not <$> isEmpty

oneElementOnStack :: EvalM Bool
oneElementOnStack = do
  l <- gets length
  pure (l == 1)
