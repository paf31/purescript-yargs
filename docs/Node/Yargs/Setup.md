## Module Node.Yargs.Setup

#### `YargsSetup`

``` purescript
data YargsSetup :: *
```

##### Instances
``` purescript
instance semigroupYargsSetup :: Semigroup YargsSetup
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

#### `demandCount`

``` purescript
demandCount :: Int -> String -> YargsSetup
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


