--

module Main where

import Expr
import TextShow (printT)

main :: IO ()
main = do
  print (myeval expr1)
  printT expr1
