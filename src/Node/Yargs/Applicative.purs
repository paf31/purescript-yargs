module Node.Yargs.Applicative 
  ( Y()
  , runY
  , Arg, arg
  , yarg
  , flag
  , rest
  ) where

import Prelude

import Data.Maybe
import Data.Foreign
import Data.Foreign.Class
import Data.Monoid
import Data.Either
import Data.Foldable (foldMap)

import Node.Yargs
import Node.Yargs.Setup

import Control.Monad.Eff
import Control.Monad.Eff.Unsafe
import Control.Monad.Eff.Console (CONSOLE())
import Control.Monad.Eff.Exception
import Control.Alt

newtype Y a = Y { setup :: YargsSetup
                , read  :: Foreign -> F a
                }

unY :: forall a. Y a -> { setup :: YargsSetup, read :: Foreign -> F a }
unY (Y y) = y

instance functorY :: Functor Y where
  map f (Y o) = Y { setup: o.setup, read: \value -> f <$> o.read value }

instance applyT :: Apply Y where
  apply (Y o1) (Y o2) = Y { setup: o1.setup <> o2.setup
                          , read: \value -> o1.read value <*> o2.read value
                          }

instance applicativeY :: Applicative Y where
  pure a = Y { setup: mempty, read: \_ -> pure a }

runY :: forall a eff. YargsSetup -> 
                      Y (Eff (err :: EXCEPTION, console :: CONSOLE | eff) a) -> 
                         Eff (err :: EXCEPTION, console :: CONSOLE | eff) a
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

readOneOrMany :: forall a. (IsForeign a) => String -> Foreign -> F (Array a)
readOneOrMany key value = (pure <$> readProp key value)
                                <|> readProp key value 

instance argStrings :: Arg (Array String) where
  arg key = Y { setup: string key 
              , read: readOneOrMany key
              }

instance argBooleans :: Arg (Array Boolean) where
  arg key = Y { setup: boolean key 
              , read: readOneOrMany key
              }
	      
instance argNumbers :: Arg (Array Number) where
  arg key = Y { setup: mempty 
              , read: readOneOrMany key
              }

yarg :: forall a. (Arg a) => String -> Array String -> Maybe String -> Either a String -> Boolean -> Y a
yarg key aliases desc required needArg = 
  let 
    y = unY (arg key)
  in Y { setup: y.setup <>
                foldMap (\a -> alias    key a) aliases <>
                foldMap (\m -> demand   key m) required <>
                foldMap (\s -> describe key s) desc <>
                if needArg then requiresArg key else mempty
       , read: case required of
           Left def -> \value -> y.read value <|> pure def
           _ -> y.read
       }

flag :: forall a. String -> Array String -> Maybe String -> Y Boolean
flag key aliases desc = yarg key aliases desc (Left false) false

rest :: Y (Array Foreign)
rest = Y { setup: mempty
         , read: readArray
         }
