## Module Node.Yargs.Setup

#### `YargsSetup`

``` purescript
data YargsSetup :: *
```

##### Instances
``` purescript
Semigroup YargsSetup
Monoid YargsSetup
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

#### `defaultHelp`

``` purescript
defaultHelp :: YargsSetup
```

Will make --help the option to trigger help output

#### `version`

``` purescript
version :: String -> String -> String -> YargsSetup
```

#### `defaultVersion`

``` purescript
defaultVersion :: YargsSetup
```

Tries to find your package.json and parse the "version" field
Will make --version the option to trigger version output

#### `showHelpOnFail`

``` purescript
showHelpOnFail :: Boolean -> String -> YargsSetup
```


