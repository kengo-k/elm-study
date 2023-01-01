module Main exposing (..)

import Form.Decoder exposing (Decoder, Validator, assert, field, identity, int, lift, map2, minBound, minLength, run, top)


type alias Product =
    { name : String, price : Int }


type alias ProductForm =
    { name : String, price : String }


type Error
    = Required
    | InvalidNumber
    | NegativeNumber


required : Validator String Error
required =
    minLength Required 1


toInt : Decoder String Error Int
toInt =
    int InvalidNumber


isPositive : Validator Int Error
isPositive =
    minBound NegativeNumber 0


name : Decoder ProductForm Error String
name =
    lift .name Form.Decoder.identity
        |> assert required


age : Decoder ProductForm Error Int
age =
    lift .price toInt
        |> assert isPositive


productDecoder : Decoder ProductForm Error Product
productDecoder =
    top Product
        |> field name
        |> field age


getProduct : ProductForm -> Result (List Error) Product
getProduct form =
    run productDecoder form
