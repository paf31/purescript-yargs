module Test.Main where

import Prelude
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (CONSOLE, logShow)
import Control.Monad.Eff.Exception (EXCEPTION)
import Control.Monad.Except (except)
import Data.Array (reverse)
import Data.Either (Either(..))
import Data.Maybe (Maybe(..))
import Node.Yargs.Applicative (flag, yarg, runY)
import Node.Yargs.Setup (example, usage)

app :: forall eff. Array String -> Boolean -> Eff (console :: CONSOLE | eff) Unit
app [] _     = pure unit
app ss false = logShow ss
app ss true  = logShow (reverse ss)

main :: forall eff. Eff (console :: CONSOLE, exception :: EXCEPTION | eff) Unit
main = do
  let setup = usage "$0 -w Word1 -w Word2"
              <> example "$0 -w Hello -w World" "Say hello!"

  runY setup $ app <$> yarg "w" ["word"] (Just "A word") (Right "At least one word is required") false
                   <*> flag "r" []       (Just "Reverse the words")
