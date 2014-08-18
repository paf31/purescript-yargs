# Module Documentation

## Module Node.Yargs

### Types

    data Console :: !

    data Yargs :: *

    data YargsSetup :: *


### Type Class Instances

    instance monoidYargsSetup :: Monoid YargsSetup

    instance semigroupYargsSetup :: Semigroup YargsSetup


### Values

    alias :: String -> String -> YargsSetup

    argv :: forall eff. Yargs -> Eff (console :: Console | eff) Foreign

    boolean :: String -> YargsSetup

    config :: String -> YargsSetup

    demand :: String -> String -> YargsSetup

    describe :: String -> String -> YargsSetup

    example :: String -> String -> YargsSetup

    help :: String -> String -> YargsSetup

    requiresArg :: String -> YargsSetup

    runYargs :: forall eff. YargsSetup -> Eff (console :: Console | eff) Foreign

    setupWith :: forall eff. YargsSetup -> Yargs -> Eff (console :: Console | eff) Yargs

    showHelpOnFail :: Boolean -> String -> YargsSetup

    strict :: YargsSetup

    string :: String -> YargsSetup

    usage :: String -> YargsSetup

    version :: String -> String -> String -> YargsSetup

    wrap :: Number -> YargsSetup

    yargs :: forall eff. Eff (console :: Console | eff) Yargs


## Module Node.Yargs.Applicative

### Types

    newtype Y a


### Type Classes

    class Arg a where
      arg :: String -> Y a


### Type Class Instances

    instance applicativeY :: Applicative Y

    instance applyT :: Apply Y

    instance argBoolean :: Arg Boolean

    instance argBooleans :: Arg [Boolean]

    instance argNumber :: Arg Number

    instance argNumbers :: Arg [Number]

    instance argString :: Arg String

    instance argStrings :: Arg [String]

    instance functorY :: Functor Y


### Values

    runY :: forall a eff. YargsSetup -> Y (Eff eff a) -> Eff (console :: Console, err :: Exception | eff) a