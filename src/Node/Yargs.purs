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
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE)
import Data.Foreign (Foreign)
import Node.Yargs.Setup (YargsSetup)

-- | The type of the `yargs` module, i.e. the result of
-- | `require('yargs')`.
foreign import data Yargs :: *

-- | Get a reference to the `yargs` module.
foreign import yargs :: forall eff. Eff (console :: CONSOLE | eff) Yargs

-- | Setup the `yargs` module.
-- |
-- | See the `Node.Yargs.Setup` module, which contains functions for creating
-- | values of type `YargsSetup`.
foreign import setupWith
  :: forall eff
   . YargsSetup
  -> Yargs
  -> Eff (console :: CONSOLE | eff) Yargs

-- | Get the raw command line arguments object, as a foreign value.
foreign import argv :: forall eff. Yargs -> Eff (console :: CONSOLE | eff) Foreign

-- | Setup the `yargs` module and get the resulting parsed command line
-- | arguments object.
runYargs :: forall eff. YargsSetup -> Eff (console :: CONSOLE | eff) Foreign
runYargs setup = yargs >>= setupWith setup >>= argv
