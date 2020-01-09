module Api.HttpLayer.Service.SampleEndpoint where

import Servant
import Control.Monad.IO.Class
import Control.Monad
import Api.HttpLayer.ExternalService.Route
import Data.Either
import Data.Aeson

sampleEndpoint :: Handler String
sampleEndpoint = liftIO sampleEndpointBL

sampleEndpointBL :: IO String
sampleEndpointBL = do
  resultCall <- replicateM 10 randomEndpoint
  (return . collect . partitionEithers) resultCall
  where
    collect (a, b) = if (null a) then foldMap (show . encode) b else foldMap show a
