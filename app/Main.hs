module Main where

import Api.HttpLayer.Service.Route
import Network.Wai.Handler.Warp

-- Create the server
-- main :: IO ()
-- main = run 8080 app

import Api.HttpLayer.ExternalService.Route

-- Call the client
main :: IO ()
main = test
