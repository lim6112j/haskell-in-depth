module EvalRPNTrans where

import Control.Monad (when)
import Control.Monad.State (StateT, get, lift, modify, put)

type Stack = [Integer]

type EvalM = StateT Stack Maybe

push :: Integer -> EvalM ()
push x = modify (x :)

pop :: EvalM Integer
pop = do
  xs <- get
  when (null xs) $ lift Nothing
  put (tail xs)
  pure (head xs)
