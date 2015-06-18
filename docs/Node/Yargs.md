## Module Node.Yargs

#### `Yargs`

``` purescript
data Yargs :: *
```

#### `yargs`

``` purescript
yargs :: forall eff. Eff (console :: CONSOLE | eff) Yargs
```

#### `setupWith`

``` purescript
setupWith :: forall eff. YargsSetup -> Yargs -> Eff (console :: CONSOLE | eff) Yargs
```

#### `argv`

``` purescript
argv :: forall eff. Yargs -> Eff (console :: CONSOLE | eff) Foreign
```

#### `runYargs`

``` purescript
runYargs :: forall eff. YargsSetup -> Eff (console :: CONSOLE | eff) Foreign
```


