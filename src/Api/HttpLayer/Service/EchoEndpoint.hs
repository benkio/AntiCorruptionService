module Api.HttpLayer.Service.EchoEndpoint where
import Servant

echoEndpoint :: String -> Handler String
echoEndpoint input = return input
