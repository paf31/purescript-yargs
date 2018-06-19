## Module Node.Yargs.Applicative

#### `Y`

``` purescript
newtype Y a
```

The `Y` applicative functor can be used to build values from
command-line arguments, providing a more idiomatic interface to
the `yargs` library.

##### Instances
``` purescript
Functor Y
Apply Y
Applicative Y
```

#### `runY`

``` purescript
runY :: forall a. YargsSetup -> Y (Effect a) -> Effect a
```

Compute some `Eff` action using command-line arguments, and run it.

This function can throw exceptions.

#### `Arg`

``` purescript
class Arg a  where
  arg :: String -> Y a
```

The `Arg` class describes types which can be parsed from the command line.

##### Instances
``` purescript
Arg String
Arg Boolean
Arg Number
Arg Int
Arg (Array String)
Arg (Array Boolean)
Arg (Array Number)
```

#### `yarg`

``` purescript
yarg :: forall a. Arg a => String -> Array String -> Maybe String -> Either a String -> Boolean -> Y a
```

Describe a single command line argument.

The arguments are, in order:

- The key name and default argument name
- Any aliases which can be used in place of the key
- An optional description
- Either a default value or a message to show if this field is required
- Whether or not an associated value is required

#### `flag`

``` purescript
flag :: String -> Array String -> Maybe String -> Y Boolean
```

Describe a boolean-valued flag.

The arguments are, in order:

- The key name and default argument name
- Any aliases which can be used in place of the key
- An optional description

#### `rest`

``` purescript
rest :: Y (Array Foreign)
```

Get the raw command line arguments object.


