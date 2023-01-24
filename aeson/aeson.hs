{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE OverloadedStrings #-}
import GHC.Generics
import Data.Aeson
import Data.Text

data Person = Person {
  name :: Text
  , age :: Int
} deriving (Generic, Show)
instance ToJSON Person where
  toEncoding = genericToEncoding defaultOptions
instance FromJSON Person

main :: IO ()
main = do
  let personByteString = encode (Person {name = "lim", age = 12})
  print personByteString
  let mvalue = decode personByteString :: Maybe Value
  print mvalue
  let mobject = decode personByteString :: Maybe Object
  print mobject
