module Node.Yargs 
  ( Yargs()
  , Console()
  
  , yargs
  , runYargs
  , argv
  , setupWith
  ) where

import Data.Foreign
import Data.Foreign.EasyFFI

import Control.Monad.Eff

import Node.Yargs.Setup

foreign import data Yargs :: *

foreign import data Console :: !

foreign import yargs
  "function yargs() {\
  \  return require('yargs');\
  \}" :: forall eff. Eff (yargs :: Console | eff) Yargs

setupWith :: forall eff. YargsSetup -> Yargs -> Eff (yargs :: Console | eff) Yargs 
setupWith = unsafeForeignFunction ["setup", "y", ""] "setup(y)"

argv :: forall eff. Yargs -> Eff (yargs :: Console | eff) Foreign
argv = unsafeForeignFunction ["y", ""] "y.argv"

runYargs :: forall eff. YargsSetup -> Eff (yargs :: Console | eff) Foreign
runYargs setup = yargs >>= setupWith setup >>= argv

