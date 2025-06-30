module Main(main) where
import TempPhantom
import UnitNameProxies
main :: IO ()
main = do
  print $ f2c paperBurning - absoluteZero
  print "\n"
  print $ unit $ f2c paperBurning
