{-# LANGUAGE DeriveGeneric #-}
{-# LANGUAGE DeriveAnyClass #-}
{-# LANGUAGE DuplicateRecordFields #-}

module Api.Domain.ExternalService where

import GHC.Generics
import Data.Text
import Data.Aeson

data Beer = Beer {
   id                :: Int
 , name              :: !Text
 , tagline           :: !Text
 , first_brewed      :: !Text
 , description       :: !Text
 , image_url         :: Maybe Text
 , abv               :: Double
 , ibu               :: Maybe Int
 , target_fg         :: Int
 , target_og         :: Int
 , ebc               :: Double
 , srm               :: Double
 , ph                :: Double
 , attenuation_level :: Double
 , volume            :: Volume
 , boil_volume       :: Volume
 , method            :: Method
 , ingredients       :: Ingredients
 , food_pairing      :: [Text]
 , brewers_tips      :: !Text
 , contributed_by    :: !Text
} deriving (Show, Generic, FromJSON, ToJSON)

newtype Volume = Volume UnitValue deriving (Show, Generic, FromJSON, ToJSON)
newtype Temperature = Temperature UnitValue deriving (Show, Generic, FromJSON, ToJSON)

data UnitValue = UnitValue {
  value :: Double
, unit  :: !Text
  } deriving (Show, Generic, FromJSON, ToJSON)

data Method = Method {
  mash_temp    :: [MashTemperature]
, fermentation :: Fermentation
, twist        :: Maybe Text
  } deriving (Show, Generic, FromJSON, ToJSON)

data MashTemperature = MashTemperature {
  temp :: Temperature
,  duration :: Maybe Int
  }  deriving (Show, Generic, FromJSON, ToJSON)

data Fermentation = Fermentation {
  temp :: Temperature
  }  deriving (Show, Generic, FromJSON, ToJSON)

data Ingredients = Ingredients {
   malt :: [Malt]
,  hops :: [Hops]
,  yeast :: Text
  } deriving (Show, Generic, FromJSON, ToJSON)

data Malt = Malt {
   name :: Text
,  amount :: UnitValue
  }  deriving (Show, Generic, FromJSON, ToJSON)

data Hops = Hops {
   name :: Text
,  amount :: UnitValue
,  add :: Text
,  attribute :: Text
  }  deriving (Show, Generic, FromJSON, ToJSON)
