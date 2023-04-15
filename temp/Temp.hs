{-# LANGUAGE OverloadedStrings #-}

import Data.Text

type SQL = Text

data ErrorMsg = WrongFormat Int Text deriving (Show)

testData :: Text
testData = "Pen:Bob\nglass:Mary:10\nPencil:Alice\nBook:Bob\nBottle"

-- getSQL :: Text -> Writer [ErrorMsg] SQL
-- genSQL txt = undefined

main :: IO ()
main = do
  putStrLn "hello"
