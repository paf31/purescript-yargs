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
import Control.Monad.Except (runExcept)
import Data.Either (Either(Left, Right))
import Data.Foldable (foldMap)
import Data.Maybe (Maybe)
import Data.Traversable (traverse)
import Effect (Effect)
import Effect.Exception (error, throwException)
import Foreign (F, Foreign, readArray, readBoolean, readInt, readNumber, readString)
import Foreign.Index (readProp)
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
runY :: forall a. YargsSetup -> Y (Effect a) -> Effect a
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
              , read: readProp key >=> readString
              }

instance argBoolean :: Arg Boolean where
  arg key = Y { setup: boolean key
              , read: readProp key >=> readBoolean
              }

instance argNumber :: Arg Number where
  arg key = Y { setup: mempty
              , read: readProp key >=> readNumber
              }

instance argInt :: Arg Int where
  arg key = Y { setup: mempty
              , read: readProp key >=> readInt
              }

readOneOrMany :: forall a. (Foreign -> F a) -> String -> Foreign -> F (Array a)
readOneOrMany f key value = do
  value' <- readProp key value
  pure <$> f value'
       <|> (readArray value' >>= traverse f)

instance argStrings :: Arg (Array String) where
  arg key = Y { setup: string key
              , read: readOneOrMany readString key
              }

instance argBooleans :: Arg (Array Boolean) where
  arg key = Y { setup: boolean key
              , read: readOneOrMany readBoolean key
              }

instance argNumbers :: Arg (Array Number) where
  arg key = Y { setup: mempty
              , read: readOneOrMany readNumber key
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
         , read: readProp "_" >=> readArray
         }
