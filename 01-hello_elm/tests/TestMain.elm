module TestMain exposing (..)

import Expect exposing (..)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "Example Test Suite"
        [ test "should equal" <|
            \() ->
                sum 1 10
                    |> Expect.equal 55
        ]
