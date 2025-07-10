{-# LANGUAGE DataKinds #-}
{-# LANGUAGE KindSignatures #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module TempKinds where
data TempUnits = F | C
newtype Temp (u :: TempUnits) = Temp Double deriving ( Num, Fractional, Show)

paperBurning :: Temp 'F
paperBurning = 451
absoluteZero :: Temp 'C
absoluteZero = -273.15
f2c :: Temp 'F -> Temp 'C
f2c (Temp f) = Temp ((f - 32) * 5 / 9)
