module Main exposing (..)

import Form.Decoder exposing (Decoder, Validator, assert, field, int, lift, map2, minBound, minLength, top)


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



--
-- [lift]
--
--  The `lift` function "lifts" a decoder up to operate on a larger structure.
--     type alias Form =
--         { field1 : String
--         , field2 : String
--         }
--     type Error
--         = TooShort
--     run (lift .field1 <| minLength TooShort 5)
--         (Form "foo" "barrrrrrrrrrr")
--     --> Err [ TooShort ]
--
-- lift : (j -> i) -> Decoder i err a -> Decoder j err a
-- lift f (Decoder g) =
--     custom <| g << f


nameDecoder_ : Decoder Form Error String
nameDecoder_ =
    lift .name nameDecoder


ageDecoder_ : Decoder Form Error Int
ageDecoder_ =
    lift .age ageDecoder



--
-- [map2]
--
-- type alias Form =
--     { str : String
--     , int : String
--     }
-- type alias Decoded =
--     { str : String
--     , int : Int
--     }
-- type Error
--     = TooShort
--     | InvalidInt
-- strDecoder : Decoder String Error String
-- strDecoder =
--     Form.Decoder.identity
--         |> assert (minLength TooShort 5)
-- intDecoder : Decoder String Error Int
-- intDecoder =
--     int InvalidInt
-- formDecoder : Decoder Form Error Decoded
-- formDecoder =
--     map2 Decoded
--         (lift .str strDecoder)
--         (lift .int intDecoder)
-- run formDecoder (Form "foo" "bar")
-- --> Err [ TooShort, InvalidInt ]
-- run formDecoder (Form "foo" "23")
-- --> Err [ TooShort ]
-- run formDecoder (Form "foobar" "bar")
-- --> Err [ InvalidInt ]
-- run formDecoder (Form "foobar" "23")
-- --> Ok (Decoded "foobar" 23)
--
-- map2 : (a -> b -> value) -> Decoder input x a -> Decoder input x b -> Decoder input x value
-- map2 f d1 d2 =
--     top f
--         |> field d1
--         |> field d2


decoder : Decoder Form Error Person
decoder =
    map2 Person
        nameDecoder_
        ageDecoder_



--
-- [top]
--
-- top : f -> Decoder i err f
-- top f =
--     custom <| \_ -> Ok f
--
--
-- [field]
--
-- It can be used as `mapN`.
--     mapN f d1 d2 d3 ... dN =
--         top f
--             |> field d1
--             |> field d2
--             |> field d3
--             ...
--             |> field dN
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


decoder2 : Decoder Form Error Person
decoder2 =
    top Person
        |> field nameDecoder_
        |> field ageDecoder_


type alias Form =
    { name : String, age : String }


type alias Person =
    { name : String, age : Int }
