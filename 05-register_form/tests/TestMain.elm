module TestMain exposing (..)

import Expect
import List exposing (foldl)
import Test exposing (..)


suite : Test
suite =
    describe "tests"
        [ test "sum 1..10 equals 55" <|
            \() ->
                let
                    sum =
                        foldl (+) 0 <| List.range 1 10
                in
                Expect.equal 55 sum
        ]
