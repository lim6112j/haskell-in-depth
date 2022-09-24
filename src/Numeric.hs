module Numeric where

import Data.Fixed

data E4

instance HasResolution E4 where
  resolution _ = 10000

type Fixed4 = Fixed E4

resol :: Fixed4
resol = 3.141583 :: Fixed4
