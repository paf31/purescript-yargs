module Node.Yargs 
  ( Yargs()
   
  , yargs
  , runYargs
  , argv
  , setupWith
  ) where

import Prelude

import Data.Foreign

import Control.Monad.Eff
import Control.Monad.Eff.Console

import Node.Yargs.Setup

import Unsafe.Coerce

foreign import data Yargs :: *

foreign import yargs :: forall eff. Eff (console :: CONSOLE | eff) Yargs

foreign import setupWith :: forall eff. YargsSetup -> Yargs -> Eff (console :: CONSOLE | eff) Yargs 

foreign import argv :: forall eff. Yargs -> Eff (console :: CONSOLE | eff) Foreign

runYargs :: forall eff. YargsSetup -> Eff (console :: CONSOLE | eff) Foreign
runYargs setup = yargs >>= setupWith setup >>= argv

