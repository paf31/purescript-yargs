# Module Documentation

## Module Node.Yargs

#### `Yargs`

``` purescript
data Yargs :: *
```


#### `Console`

``` purescript
data Console :: !
```


#### `yargs`

``` purescript
yargs :: forall eff. Eff (yargs :: Console | eff) Yargs
```


#### `setupWith`

``` purescript
setupWith :: forall eff. YargsSetup -> Yargs -> Eff (yargs :: Console | eff) Yargs
```


#### `argv`

``` purescript
argv :: forall eff. Yargs -> Eff (yargs :: Console | eff) Foreign
```


#### `runYargs`

``` purescript
runYargs :: forall eff. YargsSetup -> Eff (yargs :: Console | eff) Foreign
```



## Module Node.Yargs.Applicative

#### `Y`

``` purescript
newtype Y a
```


#### `functorY`

``` purescript
instance functorY :: Functor Y
```


#### `applyT`

``` purescript
instance applyT :: Apply Y
```


#### `applicativeY`

``` purescript
instance applicativeY :: Applicative Y
```


#### `runY`

``` purescript
runY :: forall a eff. YargsSetup -> Y (Eff (yargs :: Console, err :: Exception | eff) a) -> Eff (yargs :: Console, err :: Exception | eff) a
```


#### `Arg`

``` purescript
class Arg a where
  arg :: String -> Y a
```


#### `argString`

``` purescript
instance argString :: Arg String
```


#### `argBoolean`

``` purescript
instance argBoolean :: Arg Boolean
```


#### `argNumber`

``` purescript
instance argNumber :: Arg Number
```


#### `argStrings`

``` purescript
instance argStrings :: Arg [String]
```


#### `argBooleans`

``` purescript
instance argBooleans :: Arg [Boolean]
```


#### `argNumbers`

``` purescript
instance argNumbers :: Arg [Number]
```


#### `yarg`

``` purescript
yarg :: forall a. (Arg a) => String -> [String] -> Maybe String -> Either a String -> Boolean -> Y a
```


#### `flag`

``` purescript
flag :: forall a. String -> [String] -> Maybe String -> Y Boolean
```


#### `rest`

``` purescript
rest :: Y [Foreign]
```



## Module Node.Yargs.Setup

#### `YargsSetup`

``` purescript
data YargsSetup :: *
```


#### `semigroupYargsSetup`

``` purescript
instance semigroupYargsSetup :: Semigroup YargsSetup
```


#### `monoidYargsSetup`

``` purescript
instance monoidYargsSetup :: Monoid YargsSetup
```


#### `usage`

``` purescript
usage :: String -> YargsSetup
```


#### `example`

``` purescript
example :: String -> String -> YargsSetup
```


#### `alias`

``` purescript
alias :: String -> String -> YargsSetup
```


#### `demand`

``` purescript
demand :: String -> String -> YargsSetup
```


#### `requiresArg`

``` purescript
requiresArg :: String -> YargsSetup
```


#### `describe`

``` purescript
describe :: String -> String -> YargsSetup
```


#### `boolean`

``` purescript
boolean :: String -> YargsSetup
```


#### `string`

``` purescript
string :: String -> YargsSetup
```


#### `config`

``` purescript
config :: String -> YargsSetup
```


#### `wrap`

``` purescript
wrap :: Number -> YargsSetup
```


#### `strict`

``` purescript
strict :: YargsSetup
```


#### `help`

``` purescript
help :: String -> String -> YargsSetup
```


#### `version`

``` purescript
version :: String -> String -> String -> YargsSetup
```


#### `showHelpOnFail`

``` purescript
showHelpOnFail :: Boolean -> String -> YargsSetup
```