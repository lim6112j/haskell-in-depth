-- state = reader + writer

module MState where

import Control.Monad.State
import Data.Foldable

addItem :: Integer -> State Integer ()
addItem n = do
  s <- get
  put (n + s)

addItem' :: Integer -> State Integer ()
addItem' n = modify' (+ n)

sumItem :: [Integer] -> State Integer ()
sumItem = traverse_ addItem'
