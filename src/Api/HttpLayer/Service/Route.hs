module Api.HttpLayer.Service.Route where

import Api.HttpLayer.Service.Contract
import Api.HttpLayer.Service.EchoEndpoint
import Api.HttpLayer.Service.SampleEndpoint
import Servant

server :: Server API
server = echoEndpoint :<|> sampleEndpoint

app :: Application
app = serve api server
