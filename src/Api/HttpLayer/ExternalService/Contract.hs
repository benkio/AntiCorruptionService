{-# LANGUAGE DataKinds #-}
{-# LANGUAGE TypeOperators #-}
module Api.HttpLayer.ExternalService.Contract where

import Servant
import Api.Domain.ExternalService

type ExtenalAPI =
  "random" :>  Get '[JSON] [Beer]

externalApi :: Proxy ExtenalAPI
externalApi = Proxy
