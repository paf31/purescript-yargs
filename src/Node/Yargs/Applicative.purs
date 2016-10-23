module Node.Yargs.Applicative
  ( Y
  , runY
  , class Arg
  , arg
  , yarg
  , flag
  , rest
  ) where

import Prelude

import Control.Alt ((<|>))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Control.Monad.Eff.Exception (EXCEPTION, error, throwException)
import Control.Monad.Except (runExcept)
import Data.Either (Either(Left, Right))
import Data.Foldable (foldMap)
import Data.Foreign (Foreign, F, readArray)
import Data.Foreign.Class (class IsForeign, readProp)
import Data.Maybe (Maybe)
import Data.Monoid (mempty)
import Node.Yargs (runYargs)
import Node.Yargs.Setup (YargsSetup, requiresArg, describe, demand, alias, boolean, string)

-- | The `Y` applicative functor can be used to build values from
-- | command-line arguments, providing a more idiomatic interface to
-- | the `yargs` library.
newtype Y a = Y
  { setup :: YargsSetup
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

-- | Compute some `Eff` action using command-line arguments, and run it.
-- |
-- | This function can throw exceptions.
runY :: forall a eff. YargsSetup ->
                      Y (Eff (err :: EXCEPTION, console :: CONSOLE | eff) a) ->
                         Eff (err :: EXCEPTION, console :: CONSOLE | eff) a
runY setup (Y y) = do
  value <- runYargs (setup <> y.setup)
  case runExcept (y.read value) of
    Left err -> throwException (error (show err))
    Right action -> action

-- | The `Arg` class describes types which can be parsed from the command line.
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

readOneOrMany :: forall a. IsForeign a => String -> Foreign -> F (Array a)
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

-- | Describe a single command line argument.
-- |
-- | The arguments are, in order:
-- |
-- | - The key name and default argument name
-- | - Any aliases which can be used in place of the key
-- | - An optional description
-- | - Either a default value or a message to show if this field is required
-- | - Whether or not an associated value is required
yarg
  :: forall a
   . Arg a
  => String
  -> Array String
  -> Maybe String
  -> Either a String
  -> Boolean
  -> Y a
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

-- | Describe a boolean-valued flag.
-- |
-- | The arguments are, in order:
-- |
-- | - The key name and default argument name
-- | - Any aliases which can be used in place of the key
-- | - An optional description
flag :: String -> Array String -> Maybe String -> Y Boolean
flag key aliases desc = yarg key aliases desc (Left false) false

-- | Get the raw command line arguments object.
rest :: Y (Array Foreign)
rest = Y { setup: mempty
         , read: readArray
         }
