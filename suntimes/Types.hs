{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DeriveGeneric #-}
module Types where
import Data.Text
import GHC.Generics
import Date.Time (Day)
import Data.Aeson

type address = Text
data When = Now | On Day
  deriving Show
data GeoCoords = GeoCoords { lat:: Text, lon:: Text}
  deriving (Show, Generic, FromJson)
data SumTimes dt = SunTimes { sunrise:: dt, sunset:: dt}
  deriving (Show, Generic, FromJson)
data WebApiAuth = WebApiAuth { timeZoneDBKey :: Text, email:: Text, agent:: Text}
  deriving (Show, Generic, FromJson)
