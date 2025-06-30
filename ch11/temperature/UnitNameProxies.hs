{-# LANGUAGE InstanceSigs #-}
{-# LANGUAGE ScopedTypeVariables #-}
module UnitNameProxies where
import TempPhantom
import Data.Proxy (Proxy)

class UnitName u where
  unitName :: Proxy u -> String
-- instance UnitName F where
--   unitName :: Proxy F -> String
--   unitName _ = "F"
-- instance UnitName C where
--   unitName :: Proxy C -> String
--   unitName _ = "C"
instance UnitName unit => UnitName (Temp unit) where
  unitName _ = unitName (Proxy :: Proxy unit)
