module Node.Yargs.Setup
  ( YargsSetup()
  , usage
  , example
  , alias
  , demand
  , demandCount
  , requiresArg
  , describe
  , boolean
  , string
  , config
  , wrap
  , strict
  , help
  , defaultHelp
  , version
  , defaultVersion
  , showHelpOnFail
  ) where

import Prelude

import Data.Function.Uncurried (runFn2, runFn3, runFn0)
import Data.Monoid (class Monoid)
import Unsafe.Coerce (unsafeCoerce)

foreign import data YargsSetup :: *

instance semigroupYargsSetup :: Semigroup YargsSetup where
  append s1 s2 = unsafeCoerce \y -> unsafeCoerce s2 (unsafeCoerce s1 y)

instance monoidYargsSetup :: Monoid YargsSetup where
  mempty = unsafeCoerce \y -> y

usage :: String -> YargsSetup
usage msg = unsafeCoerce \y -> y.usage msg

example :: String -> String -> YargsSetup
example cmd desc = unsafeCoerce \y -> runFn2 y.example cmd desc

alias :: String -> String -> YargsSetup
alias key a = unsafeCoerce \y -> runFn2 y.alias key a

demand :: String -> String -> YargsSetup
demand key msg = unsafeCoerce \y -> runFn2 y.demand key msg

demandCount :: Int -> String -> YargsSetup
demandCount count desc = unsafeCoerce \y -> runFn2 y.demand count desc

requiresArg :: String -> YargsSetup
requiresArg key = unsafeCoerce \y -> y.requiresArg key

describe :: String -> String -> YargsSetup
describe key desc = unsafeCoerce \y -> runFn2 y.describe key desc

boolean :: String -> YargsSetup
boolean key = unsafeCoerce \y -> y.boolean key

string :: String -> YargsSetup
string key = unsafeCoerce \y -> y.string key

config :: String -> YargsSetup
config key = unsafeCoerce \y -> y.config key

wrap :: Number -> YargsSetup
wrap cols = unsafeCoerce \y -> y.wrap cols

strict :: YargsSetup
strict = unsafeCoerce \y -> runFn0 y.strict

help :: String -> String -> YargsSetup
help key desc = unsafeCoerce \y -> runFn2 y.help key desc

-- | Will make --help the option to trigger help output
defaultHelp :: YargsSetup
defaultHelp = unsafeCoerce \y -> runFn0 y.help

version :: String -> String -> String -> YargsSetup
version v key desc = unsafeCoerce \y -> runFn3 y.version v key desc

-- | Tries to find your package.json and parse the "version" field
-- | Will make --version the option to trigger version output
defaultVersion :: YargsSetup
defaultVersion = unsafeCoerce \y -> runFn0 y.version

showHelpOnFail :: Boolean -> String -> YargsSetup
showHelpOnFail enable msg = unsafeCoerce \y -> runFn2 y.showHelpOnFail enable msg
