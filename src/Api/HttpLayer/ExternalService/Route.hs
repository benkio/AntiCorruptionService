module Api.HttpLayer.ExternalService.Route where

import Api.HttpLayer.ExternalService.Contract
import Api.Domain.ExternalService
import Servant.Client


import Network.HTTP.Client
import Network.HTTP.Client.TLS



randomEndpoint :: ClientM [Beer]
randomEndpoint = client externalApi

-- test client raw -------------------------------------------

test :: IO ()
test = do
  manager' <- newManager tlsManagerSettings
  let url = (BaseUrl Https "api.punkapi.com" 443 "/v2/beers")
  _ <- print $ showBaseUrl url
  res <- runClientM randomEndpoint (mkClientEnv manager' url)
  case res of
    Left err -> putStrLn $ "Error: " ++ show err
    Right beers -> print beers
