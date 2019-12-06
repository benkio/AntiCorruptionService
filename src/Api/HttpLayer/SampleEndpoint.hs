module Api.HttpLayer.SampleEndpoint where

import Servant

sampleEndpoint :: Handler String
sampleEndpoint = return "Sample String"
