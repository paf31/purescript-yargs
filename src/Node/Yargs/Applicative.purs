module Node.Yargs.Applicative 
  ( Y()
  , runY
  , Arg
  , arg
  ) where

import Data.Foreign
import Data.Monoid
import Data.Either

import Node.Yargs

import Control.Monad.Eff
import Control.Monad.Eff.Unsafe
import Control.Monad.Eff.Exception

newtype Y a = Y { setup :: YargsSetup
                , read  :: ForeignParser a
                }

instance functorY :: Functor Y where
  (<$>) f (Y o) = Y { setup: o.setup, read: f <$> o.read }

instance applyT :: Apply Y where
  (<*>) (Y o1) (Y o2) = Y { setup: o1.setup <> o2.setup
                          , read: o1.read <*> o2.read
                          }

instance applicativeY :: Applicative Y where
  pure a = Y { setup: mempty, read: pure a }

runY :: forall a eff. YargsSetup -> Y (Eff eff a) -> Eff (err :: Exception, console :: Console | eff) a
runY setup (Y y) = do
  value <- runYargs (setup <> y.setup)
  case parseForeign y.read value of
    Left err -> throwException (error err)
    Right action -> unsafeInterleaveEff action

class Arg a where
  arg :: String -> Y a

instance argString :: Arg String where
  arg key = Y { setup: string key 
              , read: prop key
              }

instance argBoolean :: Arg Boolean where
  arg key = Y { setup: boolean key 
              , read: prop key
              }
	      
instance argNumber :: Arg Number where
  arg key = Y { setup: mempty 
              , read: prop key
              }

instance argStrings :: Arg [String] where
  arg key = Y { setup: string key 
              , read: prop key
              }

instance argBooleans :: Arg [Boolean] where
  arg key = Y { setup: boolean key 
              , read: prop key
              }
	      
instance argNumbers :: Arg [Number] where
  arg key = Y { setup: mempty 
              , read: prop key
              }
