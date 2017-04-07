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
yargs :: forall eff. Eff (console :: CONSOLE | eff) Yargs
```

Get a reference to the `yargs` module.

#### `setupWith`

``` purescript
setupWith :: forall eff. YargsSetup -> Yargs -> Eff (console :: CONSOLE | eff) Yargs
```

Setup the `yargs` module.

See the `Node.Yargs.Setup` module, which contains functions for creating
values of type `YargsSetup`.

#### `argv`

``` purescript
argv :: forall eff. Yargs -> Eff (console :: CONSOLE | eff) Foreign
```

Get the raw command line arguments object, as a foreign value.

#### `runYargs`

``` purescript
runYargs :: forall eff. YargsSetup -> Eff (console :: CONSOLE | eff) Foreign
```

Setup the `yargs` module and get the resulting parsed command line
arguments object.


