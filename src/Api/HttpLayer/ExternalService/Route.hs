module Api.HttpLayer.ExternalService.Route where

import Api.HttpLayer.ExternalService.Contract
import Api.Domain.ExternalService
import Servant.Client
import Network.HTTP.Client
import Network.HTTP.Client.TLS

tlsManager :: IO Manager
tlsManager = newManager tlsManagerSettings

randomEndpointClient :: ClientM [Beer]
randomEndpointClient = client externalApi

randomEndpoint :: IO (Either ClientError [Beer])
randomEndpoint = do
  man <- tlsManager
  runClientM randomEndpointClient (mkClientEnv man punkUrl)
