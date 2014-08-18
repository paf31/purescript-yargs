module Main where

import Data.Either
import Data.Foreign

import Node.Yargs

import Debug.Trace

data Args = Args 
  { x :: String
  , y :: String 
  , reverse :: Boolean
  }

instance readForeignArgs :: ReadForeign Args where
  read = do
    x <- prop "x"
    y <- prop "y"
    reverse <- prop "reverse"
    return $ Args { x: x, y: y, reverse: reverse }

main = do
  let setup = usage "$0 -x Word1 -y Word2" 
                <> example "$0 -x Hello -y World" "Say hello!"
	        <> alias "x" "first"
                <> alias "y" "second"
                <> alias "r" "reverse"
                <> demand "x" "First argument is required"
                <> demand "y" "Second argument is required"
                <> string "x"
                <> string "y"
		<> boolean "r"
                <> requiresArg "x"
		<> requiresArg "y"
 		<> describe "x" "The first word"
                <> describe "y" "The second word"
		<> describe "r" "Reverse the words"

  args <- runYargs setup
  case parseForeign read args of
    Left err -> print err
    Right (Args o) | o.reverse -> trace $ o.y ++ " " ++ o.x
    Right (Args o) -> trace $ o.x ++ " " ++ o.y
