{-# LANGUAGE TypeApplications #-}
{-# LANGUAGE AllowAmbiguousTypes #-}
{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE PolyKinds #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}
{-# OPTIONS_GHC -Wno-orphans #-}
module UnitNameTypeApps where
import TempPhantom
class UnitName u where
  unitName :: String
instance UnitName C where
  unitName = "C"
instance UnitName F where
  unitName = "F"
instance UnitName Temp where
  unitName = "_unspecified unit_"
instance UnitName u => UnitName (Temp u) where
  unitName = unitName @u
instance UnitName u => Show (Temp u) where
  show (Temp t) = show t ++ "o" ++ unitName @u
