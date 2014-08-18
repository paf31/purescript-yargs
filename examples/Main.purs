module Main where

import Data.Either
import Data.Foreign

import Node.Yargs
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
	        <> alias "w" "word"
                <> alias "r" "reverse"
                <> demand "w" "At least one word is required"
                <> requiresArg "w"
 		<> describe "w" "A word"
		<> describe "r" "Reverse the words"

  runY setup (app <$> arg "w" <*> arg "r")
