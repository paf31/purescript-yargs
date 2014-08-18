module Node.Yargs 
  ( Yargs()
  , Console()
  
  , yargs
  , argv
  , usage
  , example
  , alias
  , demand
  , requiresArg
  , describe
  ) where

import Data.Foreign
import Data.Foreign.EasyFFI

import Control.Monad.Eff

foreign import data Yargs :: *

foreign import data Console :: !

foreign import yargs
  "function yargs() {\
  \  return require('yargs');\
  \}" :: forall eff. Eff (console :: Console | eff) Yargs

argv :: forall eff. Yargs -> Eff (console :: Console | eff) Foreign
argv = unsafeForeignFunction ["y", ""] "y.argv"

usage :: forall eff. String -> Yargs -> Eff (console :: Console | eff) Yargs
usage = unsafeForeignFunction ["msg", "y", ""] "y.usage(msg)"

example :: forall eff. String -> String -> Yargs -> Eff (console :: Console | eff) Yargs
example = unsafeForeignFunction ["cmd", "desc", "y", ""] "y.example(cmd, desc)"

alias :: forall eff. String -> String -> Yargs -> Eff (console :: Console | eff) Yargs 
alias = unsafeForeignFunction ["key", "alias", "y", ""] "y.alias(key, alias)"

demand :: forall eff. String -> String -> Yargs -> Eff (console :: Console | eff) Yargs
demand = unsafeForeignFunction ["key", "msg", "y", ""] "y.demand(key, msg)"

requiresArg :: forall eff. String -> Yargs -> Eff (console :: Console | eff) Yargs
requiresArg = unsafeForeignFunction ["key", "y", ""] "y.requiresArg(key)"

describe :: forall eff. String -> String -> Yargs -> Eff (console :: Console | eff) Yargs
describe = unsafeForeignFunction ["key", "desc", "y", ""] "y.describe(key, desc)"
