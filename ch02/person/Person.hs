{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE StandaloneDeriving #-}

module Person where

import Data.String (IsString (fromString))

data Person = Person String (Maybe Int)

homer :: Person
homer = Person "Homer Simpson" (Just 20)

spj :: Person
spj = Person "Simon Peterson Johns" Nothing

deriving instance Eq Person

deriving instance Show Person

deriving instance Read Person

instance IsString Person where
  fromString name = Person name Nothing

-- overloadedstrings extension
overloadedSpj :: Person
overloadedSpj = "Simon  Peterson Johns"
