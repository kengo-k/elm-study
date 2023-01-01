module TestMain exposing (..)

import Expect
import List exposing (foldl)
import Main
import Test exposing (..)


suite : Test
suite =
    describe "tests"
        [ test "sum 1..10 equals 55" <|
            \() ->
                let
                    result =
                        Main.getProduct { name = "", price = "" }
                in
                case result of
                    Ok _ ->
                        Expect.fail "should fail"

                    Err errors ->
                        Expect.equal (List.length errors) 2
        ]
