## Module Node.Yargs.Setup

#### `YargsSetup`

``` purescript
data YargsSetup :: *
```

A value which can be used to configure the `yargs` module.

The `Semigroup` and `Monoid` instances can be used to combine the various
options, which are made available as functions by this module:

```purescript
setup = fold
  [ usage "$0 -w Word1 -w Word2"
  , example "$0 -w Hello -w World" "Say hello!"
  ]
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

Provide a usage message.

#### `example`

``` purescript
example :: String -> String -> YargsSetup
```

Provide an example command and description.

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

Will make `--help` the option to trigger help output

#### `version`

``` purescript
version :: String -> String -> String -> YargsSetup
```

#### `defaultVersion`

``` purescript
defaultVersion :: YargsSetup
```

Tries to find your package.json and parse the "version" field
Will make `--version` the option to trigger version output

#### `showHelpOnFail`

``` purescript
showHelpOnFail :: Boolean -> String -> YargsSetup
```


