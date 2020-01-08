module Api.HttpLayer.Service.SampleEndpoint where

import Servant

sampleEndpoint :: Handler String
sampleEndpoint = return "Sample String"
