{-# LANGUAGE TypeOperators #-}
module TypeOperators where
data a + b = Inl a | Inr b deriving Show
data a * b = a :*: b deriving Show
infixl 6 +
infixl 7 *
