module Main exposing (..)

import Form.Decoder exposing (Decoder, Validator, assert, int, lift, map2, minBound, minLength)


type Error
    = Required
    | IntInvalid
    | MinusInt


notEmpty : Validator String Error
notEmpty =
    minLength Required 1


myInt : Decoder String Error Int
myInt =
    int IntInvalid


notMinus : Validator Int Error
notMinus =
    minBound MinusInt 0


nameDecoder : Decoder String Error String
nameDecoder =
    Form.Decoder.identity
        |> assert notEmpty


ageDecoder : Decoder String Error Int
ageDecoder =
    myInt
        |> assert notMinus


nameDecoder_ : Decoder Form Error String
nameDecoder_ =
    lift .name nameDecoder


ageDecoder_ : Decoder Form Error Int
ageDecoder_ =
    lift .age ageDecoder


decoder : Decoder Form Error Person
decoder =
    map2 Person
        nameDecoder_
        ageDecoder_


type alias Form =
    { name : String, age : String }


type alias Person =
    { name : String, age : Int }



-- lift : (j -> i) -> Decoder i err a -> Decoder j err a
-- lift f (Decoder g)
--
-- The lift function "lifts" a decoder up to operate on a larger structure.
-- type alias Form =
--     { field1 : String
--     , field2 : String
--     }
-- type Error
--     = TooShort
-- run (lift .field1 <| minLength TooShort 5)
--     (Form "foo" "barrrrrrrrrrr")
-- --> Err [ TooShort ]
--
-- Build up decoder for form.
-- It can be used as `mapN`.
--     mapN f d1 d2 d3 ... dN =
--         top f
--             |> field d1
--             |> field d2
--             |> field d3
--             ...
--             |> field dN
--
--
-- field : Decoder i err a -> Decoder i err (a -> b) -> Decoder i err b
-- field (Decoder f) (Decoder g) =
--     custom <|
--         \i ->
--             case ( g i, f i ) of
--                 ( Err gErr, Err fErr ) ->
--                     Err <| gErr ++ fErr
--                 ( Ok h, res ) ->
--                     Result.map h res
--                 ( Err gErr, Ok _ ) ->
--                     Err gErr
