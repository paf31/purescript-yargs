## Module Node.Yargs.Applicative

#### `Y`

``` purescript
newtype Y a
```

##### Instances
``` purescript
instance functorY :: Functor Y
instance applyT :: Apply Y
instance applicativeY :: Applicative Y
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
instance argString :: Arg String
instance argBoolean :: Arg Boolean
instance argNumber :: Arg Number
instance argStrings :: Arg (Array String)
instance argBooleans :: Arg (Array Boolean)
instance argNumbers :: Arg (Array Number)
```

#### `yarg`

``` purescript
yarg :: forall a. (Arg a) => String -> Array String -> Maybe String -> Either a String -> Boolean -> Y a
```

#### `flag`

``` purescript
flag :: forall a. String -> Array String -> Maybe String -> Y Boolean
```

#### `rest`

``` purescript
rest :: Y (Array Foreign)
```


