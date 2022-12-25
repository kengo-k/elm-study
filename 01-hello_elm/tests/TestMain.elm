module TestMain exposing (..)

import Expect exposing (..)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "tests"
        [ test "should sum 1..10 equals 55" <|
            \() ->
                sum 1 10
                    |> Expect.equal 55
        , test "should haveBirthday add age + 1" <|
            \() ->
                haveBirthday { name = "Yamada", age = 25 }
                    |> Expect.equal { name = "Yamada", age = 26 }
        , test "should haveBirthday2 add age + 1" <|
            \() ->
                haveBirthday { name = "Tanaka", age = 32 }
                    |> Expect.equal { name = "Tanaka", age = 33 }
        ]
