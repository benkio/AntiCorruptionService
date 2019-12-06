module Api.HttpLayer.Route where

import Api.Contract
import Api.HttpLayer.EchoEndpoint
import Api.HttpLayer.SampleEndpoint
import Servant

server :: Server API
server = echoEndpoint :<|> sampleEndpoint

app :: Application
app = serve api server
