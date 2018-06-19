-- | Low-level bindings to the `yargs` library.
-- |
-- | For a more idiomatic interface, consider using the
-- | `Node.Yargs.Applicative` module.
module Node.Yargs
  ( Yargs
  , yargs
  , runYargs
  , argv
  , setupWith
  ) where

import Prelude
import Effect (Effect)
import Foreign (Foreign)
import Node.Yargs.Setup (YargsSetup)

-- | The type of the `yargs` module, i.e. the result of
-- | `require('yargs')`.
foreign import data Yargs :: Type

-- | Get a reference to the `yargs` module.
foreign import yargs :: Effect Yargs

-- | Setup the `yargs` module.
-- |
-- | See the `Node.Yargs.Setup` module, which contains functions for creating
-- | values of type `YargsSetup`.
foreign import setupWith
  :: YargsSetup
  -> Yargs
  -> Effect Yargs

-- | Get the raw command line arguments object, as a foreign value.
foreign import argv :: Yargs -> Effect Foreign

-- | Setup the `yargs` module and get the resulting parsed command line
-- | arguments object.
runYargs :: YargsSetup -> Effect Foreign
runYargs setup = yargs >>= setupWith setup >>= argv
