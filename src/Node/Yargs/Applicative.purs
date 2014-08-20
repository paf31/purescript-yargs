module Node.Yargs.Applicative 
  ( Y()
  , runY
  , Arg
  , arg
  ) where

import Data.Foreign
import Data.Foreign.Class
import Data.Monoid
import Data.Either

import Node.Yargs
import Node.Yargs.Setup

import Control.Monad.Eff
import Control.Monad.Eff.Unsafe
import Control.Monad.Eff.Exception

newtype Y a = Y { setup :: YargsSetup
                , read  :: Foreign -> F a
                }

instance functorY :: Functor Y where
  (<$>) f (Y o) = Y { setup: o.setup, read: \value -> f <$> o.read value }

instance applyT :: Apply Y where
  (<*>) (Y o1) (Y o2) = Y { setup: o1.setup <> o2.setup
                          , read: \value -> o1.read value <*> o2.read value
                          }

instance applicativeY :: Applicative Y where
  pure a = Y { setup: mempty, read: \_ -> pure a }

runY :: forall a eff. YargsSetup -> Y (Eff eff a) -> Eff (err :: Exception, console :: Console | eff) a
runY setup (Y y) = do
  value <- runYargs (setup <> y.setup)
  case y.read value of
    Left err -> throwException (error (show err))
    Right action -> unsafeInterleaveEff action

class Arg a where
  arg :: String -> Y a

instance argString :: Arg String where
  arg key = Y { setup: string key 
              , read: readProp key
              }

instance argBoolean :: Arg Boolean where
  arg key = Y { setup: boolean key 
              , read: readProp key
              }
	      
instance argNumber :: Arg Number where
  arg key = Y { setup: mempty 
              , read: readProp key
              }

instance argStrings :: Arg [String] where
  arg key = Y { setup: string key 
              , read: readProp key
              }

instance argBooleans :: Arg [Boolean] where
  arg key = Y { setup: boolean key 
              , read: readProp key
              }
	      
instance argNumbers :: Arg [Number] where
  arg key = Y { setup: mempty 
              , read: readProp key
              }
