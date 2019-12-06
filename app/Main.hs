module Main where

import Api.HttpLayer.Route
import Network.Wai.Handler.Warp

main :: IO ()
main = run 8080 app
