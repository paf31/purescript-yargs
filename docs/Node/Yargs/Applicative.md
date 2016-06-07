## Module Node.Yargs.Applicative

#### `Y`

``` purescript
newtype Y a
```

##### Instances
``` purescript
Functor Y
Apply Y
Applicative Y
```

#### `runY`

``` purescript
runY :: forall a eff. YargsSetup -> Y (Eff (err :: EXCEPTION, console :: CONSOLE | eff) a) -> Eff (err :: EXCEPTION, console :: CONSOLE | eff) a
```

#### `Arg`

``` purescript
class Arg a where
  arg :: String -> Y a
```

##### Instances
``` purescript
Arg String
Arg Boolean
Arg Number
Arg (Array String)
Arg (Array Boolean)
Arg (Array Number)
```

#### `yarg`

``` purescript
yarg :: forall a. Arg a => String -> Array String -> Maybe String -> Either a String -> Boolean -> Y a
```

#### `flag`

``` purescript
flag :: String -> Array String -> Maybe String -> Y Boolean
```

#### `rest`

``` purescript
rest :: Y (Array Foreign)
```


