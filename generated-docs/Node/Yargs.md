## Module Node.Yargs

Low-level bindings to the `yargs` library.

For a more idiomatic interface, consider using the
`Node.Yargs.Applicative` module.

#### `Yargs`

``` purescript
data Yargs :: Type
```

The type of the `yargs` module, i.e. the result of
`require('yargs')`.

#### `yargs`

``` purescript
yargs :: Effect Yargs
```

Get a reference to the `yargs` module.

#### `runYargs`

``` purescript
runYargs :: YargsSetup -> Effect Foreign
```

Setup the `yargs` module and get the resulting parsed command line
arguments object.

#### `argv`

``` purescript
argv :: Yargs -> Effect Foreign
```

Get the raw command line arguments object, as a foreign value.

#### `setupWith`

``` purescript
setupWith :: YargsSetup -> Yargs -> Effect Yargs
```

Setup the `yargs` module.

See the `Node.Yargs.Setup` module, which contains functions for creating
values of type `YargsSetup`.


