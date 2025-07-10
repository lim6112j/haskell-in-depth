{-# LANGUAGE TypeOperators #-}
{-# OPTIONS_GHC -Wno-missing-export-lists #-}
module TypeOperators where
data a :+: b = Inl a | Inr b deriving Show
data a :*: b = a :*: b deriving Show
infixl 6 :+:
infixl 7 :*:
first :: a :*: b -> a
first (a :*: b) = a
second :: a :*: b -> b
second (a :*: b) = b
-- example usage:

-- Create a product of an Int and a String
myProduct :: Int :*: String
myProduct = 42 :*: "hello"

-- Use first and second to extract values
-- > first myProduct
-- 42
-- > second myProduct
-- "hello"

--
val1 :: Int :+: Bool :*: Bool
val1 = Inl 0
val2 :: Int :+: Bool :*: Bool
val2 = Inr (True :*: False)

-- A function that can handle the sum type
processSum :: (Show a, Show b) => a :+: b -> String
processSum (Inl a) = "Got Left: " ++ show a
processSum (Inr b) = "Got Right: " ++ show b

-- > processSum val1
-- "Got Left: True"
-- > processSum val2
-- "Got Right: 'c'"
