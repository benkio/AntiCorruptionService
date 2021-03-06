{-# LANGUAGE OverloadedStrings #-}
module Api.Domain.ExternalServiceSpec where

import Test.Hspec
import Api.Domain.ExternalService
import Data.Aeson
import Data.List
import Data.ByteString.Lazy.Internal

-- Sample Data ---------------------------------

tempSample = "{\"value\":65,\"unit\":\"celsius\"}"
fermentationSample = "{\"temp\":{\"value\":21,\"unit\":\"celsius\"}}"
maltSample1 = "{\"amount\":{\"value\":5.75,\"unit\":\"kilograms\"},\"name\":\"ExtraPale\"}"
maltSample2 = "{\"amount\":{\"value\":0.63,\"unit\":\"kilograms\"},\"name\":\"Caramalt\"}"
maltSample3 = "{\"amount\":{\"value\":0.63,\"unit\":\"kilograms\"},\"name\":\"Wheat\"}"
mashTempSample1 = "{\"temp\":{\"value\":65,\"unit\":\"celsius\"},\"duration\":75}"
mashTempSample2 = "{\"temp\":{\"value\":65,\"unit\":\"celsius\"},\"duration\":null}"
hopsSample1 = "{\"attribute\":\"aroma\",\"amount\":{\"value\":187.5,\"unit\":\"grams\"},\"add\":\"dryhop\",\"name\":\"Mosaic\"}"
hopsSample2 = "{\"attribute\":\"flavour\",\"amount\":{\"value\":20,\"unit\":\"grams\"},\"add\":\"end\",\"name\":\"Blueberries\"}"
hopsSample3 = "{\"attribute\":\"flavour\",\"amount\":{\"value\":37.5,\"unit\":\"grams\"},\"add\":\"end\",\"name\":\"Mosaic\"}"
hopsSample4 = "{\"attribute\":\"flavour\",\"amount\":{\"value\":37.5,\"unit\":\"grams\"},\"add\":\"middle\",\"name\":\"Mosaic\"}"
hopsSample5 = "{\"attribute\":\"bitter\",\"amount\":{\"value\":12.5,\"unit\":\"grams\"},\"add\":\"start\",\"name\":\"Mosaic\"}"
ingredientsSample =
  (packChars . filter (\c -> (not (elem c [' ', '\n']))) .unpackChars . mconcat) ["{\"malt\":[", jsonMalts, "],\"yeast\":\"Wyeast1272-AmericanAleII\",\"hops\":[", jsonHops, "]}"]
  where
    jsonMalts = mconcat $ intersperse (packChars ", ") [maltSample1, maltSample2, maltSample3]
    jsonHops = mconcat $ intersperse (packChars ", ") [hopsSample1, hopsSample2, hopsSample3, hopsSample4, hopsSample5]

methodSample = (packChars . filter (\c -> (not (elem c [' ', '\n']))) .unpackChars . mconcat) [ "{\"twist\":null,\"fermentation\":", fermentationSample, ",\"mash_temp\":[", jsonMashTemps, "]}"]
  where
    jsonMashTemps = mconcat $ intersperse (packChars ", ") [mashTempSample1, mashTempSample2]

beerSample = mconcat ["{\"srm\":45,\"volume\":", tempSample,",\"attenuation_level\":79.7,\"image_url\":\"https://images.punkapi.com/v2/29.png\",\"ibu\":70,\"target_og\":1074,\"ingredients\":", ingredientsSample, ",\"tagline\":\"ImperialRedAle.\",\"ebc\":90,\"target_fg\":1015,\"name\":\"10HeadsHigh\",\"method\":", methodSample, ",\"boil_volume\":", tempSample, ",\"brewers_tips\":\"AchievetheredcolourbyusingtheratioofCaramalt,CrystalandDarkCrystalmalts.Thetrickistogetthecolour,withouttoomuchdriedfruitcharacter.\",\"food_pairing\":[\"Arrabiatapasta\",\"Mulledcheddar\",\"Toastedalmondcake\"],\"id\":29,\"abv\":7.8,\"ph\":4.4,\"contributed_by\":\"SamMason<samjbmason>\",\"first_brewed\":\"04/2013\",\"description\":\"10HeadsHighislooselybasedonourawesome2011PrototypebeerHopsKillNazis.Thisisanuncompromising7.8%ImperialRedAleloadedhighwithAmericanHops.ThinkofthisasanImperialIndiaRedAle,orasuper-chargedversionof5amSaint.Eitherwaythisisaseriouslygoodbeer!\"}"]

spec :: Spec
spec = do
  describe "JSON Encoding Decoding" $ do
    it "UnitValue: Temperature + Volume" $ do
      encode (decode tempSample :: Maybe UnitValue) `shouldBe` tempSample
      encode (decode tempSample :: Maybe Temperature) `shouldBe` tempSample
      encode (decode tempSample :: Maybe Volume) `shouldBe` tempSample
    it "Fermentation" $ do
      encode (decode fermentationSample :: Maybe Fermentation) `shouldBe` fermentationSample
    it "Malt" $ do
      encode (decode maltSample1 :: Maybe Malt) `shouldBe` maltSample1
      encode (decode maltSample2 :: Maybe Malt) `shouldBe` maltSample2
      encode (decode maltSample3 :: Maybe Malt) `shouldBe` maltSample3
    it "Mash Temperature" $ do
      encode (decode mashTempSample1 :: Maybe MashTemperature) `shouldBe` mashTempSample1
      encode (decode mashTempSample2 :: Maybe MashTemperature) `shouldBe` mashTempSample2
    it "Hops" $ do
      encode (decode hopsSample1 :: Maybe Hops) `shouldBe` hopsSample1
      encode (decode hopsSample2 :: Maybe Hops) `shouldBe` hopsSample2
      encode (decode hopsSample3 :: Maybe Hops) `shouldBe` hopsSample3
      encode (decode hopsSample4 :: Maybe Hops) `shouldBe` hopsSample4
      encode (decode hopsSample5 :: Maybe Hops) `shouldBe` hopsSample5
    it "Ingredients" $ do
      encode (decode ingredientsSample :: Maybe Ingredients) `shouldBe` ingredientsSample
    it "Method" $ do
      encode (decode methodSample :: Maybe Method) `shouldBe` methodSample
    it "Beer" $ do
      encode (decode beerSample :: Maybe Beer) `shouldBe` beerSample
