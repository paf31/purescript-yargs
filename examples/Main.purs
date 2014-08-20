module Main where

import Data.Maybe
import Data.Either
import Data.Foreign

import Node.Yargs
import Node.Yargs.Setup
import Node.Yargs.Applicative

import Debug.Trace

import Control.Monad.Eff

app :: forall eff. [String] -> Boolean -> Eff (trace :: Trace | eff) Unit
app []       _     = return unit
app (s : ss) false = do
  trace s
  app ss false
app (s : ss) true  = do
  app ss true
  trace s

main = do
  let setup = usage "$0 -w Word1 -w Word2" 
              <> example "$0 -w Hello -w World" "Say hello!"
  
  runY setup $ app <$> yarg "w" ["word"] (Just "A word") (Just "At least one word is required") false 
                   <*> flag "r" []       (Just "Reverse the words")
