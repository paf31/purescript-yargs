module Node.Yargs 
  ( Yargs()
   
  , yargs
  , runYargs
  , argv
  , setupWith
  ) where

import Prelude

import Data.Foreign
import Data.Foreign.EasyFFI

import Control.Monad.Eff
import Control.Monad.Eff.Console

import Node.Yargs.Setup

foreign import data Yargs :: *

foreign import yargs :: forall eff. Eff (console :: CONSOLE | eff) Yargs

setupWith :: forall eff. YargsSetup -> Yargs -> Eff (console :: CONSOLE | eff) Yargs 
setupWith = unsafeForeignFunction ["setup", "y", ""] "setup(y)"

argv :: forall eff. Yargs -> Eff (console :: CONSOLE | eff) Foreign
argv = unsafeForeignFunction ["y", ""] "y.argv"

runYargs :: forall eff. YargsSetup -> Eff (console :: CONSOLE | eff) Foreign
runYargs setup = yargs >>= setupWith setup >>= argv

