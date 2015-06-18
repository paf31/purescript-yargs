module Test.Main where

import Prelude

import Data.Maybe
import Data.Array (reverse)
import Data.Either
import Data.Foreign

import Node.Yargs
import Node.Yargs.Setup
import Node.Yargs.Applicative

import Control.Monad.Eff
import Control.Monad.Eff.Console

app :: forall eff. Array String -> Boolean -> Eff (console :: CONSOLE | eff) Unit
app [] _     = return unit
app ss false = print ss
app ss true  = print (reverse ss)

main = do
  let setup = usage "$0 -w Word1 -w Word2" 
              <> example "$0 -w Hello -w World" "Say hello!"
  
  runY setup $ app <$> yarg "w" ["word"] (Just "A word") (Right "At least one word is required") false 
                   <*> flag "r" []       (Just "Reverse the words")
