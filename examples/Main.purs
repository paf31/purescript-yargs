module Main where

import Data.Either
import Data.Foreign

import Node.Yargs

import Debug.Trace

import Control.Bind

data Args = Args { x :: String, y :: String }

instance readForeignArgs :: ReadForeign Args where
  read = do
    x <- prop "x"
    y <- prop "y"
    return $ Args { x: x, y: y }

main = do
  let getArgs = usage "$0 -x Word1 -y Word2" 
                >=> example "$0 -x Hello -y World" "Say hello!"
		>=> alias "x" "first"
                >=> alias "y" "second"
                >=> demand "x" "First argument is required"
                >=> demand "y" "Second argument is required"
                >=> requiresArg "x"
		>=> requiresArg "y"
 		>=> describe "x" "The first word"
                >=> describe "y" "The second word"
                >=> argv

  args <- yargs >>= getArgs
  case parseForeign read args of
    Left err -> print err
    Right (Args o) -> trace $ o.x ++ " " ++ o.y
