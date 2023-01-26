{-# LANGUAGE GeneralizedNewtypeDeriving #-}
module App where
import Control.Monad.Reader
import Control.Monad.Catch
import Types
newtype MyApp a = MyApp {
  runApp :: ReaderT WebApiAuth IO a
} deriving (Functor, Applicative, Monad, MonadIO, MonadThrow, MonadCatch, MonadMask, MonadReader WebApiAuth)

runMyApp :: MyApp a -> WebApiAuth -> IO a
runMyApp app = runReaderT (runApp app)

