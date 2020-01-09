{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Api.HttpLayer.ExternalService.Contract where

import Servant
import Servant.Client
import Api.Domain.ExternalService

punkUrl :: BaseUrl
punkUrl = (BaseUrl Https "api.punkapi.com" 443 "/v2/beers")

type ExtenalAPI =
  "random" :>  Get '[JSON] [Beer]

externalApi :: Proxy ExtenalAPI
externalApi = Proxy
