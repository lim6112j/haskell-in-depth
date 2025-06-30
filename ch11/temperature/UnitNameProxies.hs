{-# LANGUAGE ScopedTypeVariables #-}
{-# LANGUAGE DataKinds #-}
{-# LANGUAGE PolyKinds #-}
{-# LANGUAGE InstanceSigs #-}

module UnitNameProxies where
import TempPhantom
import Data.Proxy

class UnitName u where
  unitName :: Proxy u -> String
instance UnitName F where
  unitName :: Proxy F -> String
  unitName _ = "F"
instance UnitName C where
  unitName :: Proxy C -> String
  unitName _ = "C"
instance UnitName unit => UnitName (Temp unit) where
  unitName _ = unitName (Proxy :: Proxy unit)
instance UnitName unit => Show (Temp unit) where
  show (Temp t) = show t ++ "º" ++ unitName (Proxy :: Proxy unit)
instance UnitName Temp where
  unitName _ = "__unspecified unit__"
unit :: forall u. UnitName u => Temp u -> String
unit _ = unitName (Proxy :: Proxy u)
