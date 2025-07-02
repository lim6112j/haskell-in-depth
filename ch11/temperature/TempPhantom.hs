{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module TempPhantom (Temp(..), F, C, paperBurning, absoluteZero, f2c) where
newtype Temp unit = Temp Double deriving (Num, Fractional)
data F
data C
paperBurning :: Temp F
paperBurning = 451
absoluteZero :: Temp C
absoluteZero = -273.15
f2c :: Temp F -> Temp C
f2c (Temp f) = Temp ((f - 32) * 5 / 9)
