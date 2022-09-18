{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE ViewPatterns #-}

module GenSQL
  ( testSQL,
  )
where

import Control.Monad.Writer
import Data.Foldable (traverse_)
import qualified Data.String
import Data.Text hiding (zip)
import qualified Data.Text as T hiding (zip)
import qualified Data.Text.IO as TIO

type SQL = Text

data ErrorMsg = WrongFormat Int Text deriving (Show)

genSQL :: Text -> Writer [ErrorMsg] SQL
genSQL txt = T.concat <$> traverse processLine (zip [1 ..] $ T.lines txt) :: Writer [ErrorMsg] Text

genInsert :: (Semigroup a, Data.String.IsString a) => a -> a -> a
genInsert s1 s2 = "INSERT INTO items VALUES ('" <> s1 <> "','" <> s2 <> "');\n"

processLine :: (Int, Text) -> Writer [ErrorMsg] SQL
processLine (_, T.splitOn ":" -> [s1, s2]) = pure $ genInsert s1 s2
processLine (i, s) = tell [WrongFormat i s] >> pure ""

testData :: Text
testData = "Pen:Bob\nglass:Mary:10\nPencil:Alice\nBook:Bob\nBottle"

testSQL :: IO ()
testSQL = do
  let (sql, errors) = runWriter (genSQL testData)
  TIO.putStrLn "SQL: "
  TIO.putStr sql
  TIO.putStrLn "errors: "
  traverse_ print errors
