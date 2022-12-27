module TestMain exposing (..)

import Expect exposing (..)
import Json.Decode exposing (Error, decodeString)
import Main exposing (..)
import Test exposing (..)


suite : Test
suite =
    describe "tests"
        [ test "sum 1..10 equals 55" <|
            \() ->
                sum 1 10
                    |> Expect.equal 55
        , test "haveBirthday add age + 1" <|
            \() ->
                haveBirthday { name = "Yamada", age = 25 }
                    |> Expect.equal { name = "Yamada", age = 26 }
        , test "haveBirthday2 add age + 1" <|
            \() ->
                haveBirthday { name = "Tanaka", age = 32 }
                    |> Expect.equal { name = "Tanaka", age = 33 }
        , test "sumstr ['1','2','3'] equals 6" <|
            \() ->
                sumstr [ "1", "2", "3" ]
                    |> Expect.equal 6
        , test "doublePlusOne 50 equals 101" <|
            \() ->
                doublePlusOne 50
                    |> Expect.equal 101
        , test "doublePlusOne1 50 equals 101" <|
            \() ->
                doublePlusOne1 50
                    |> Expect.equal 101

        -- FIXME
        -- decode結果の変数をここでテストするのではなく、ここでdecode処理を呼び出してテストしたい
        , test "person1" <|
            \() ->
                person1
                    |> Expect.equal (Ok { name = "Yamada", age = 20 })

        -- FIXME
        -- decode結果の変数をここでテストするのではなく、ここでdecode処理を呼び出してテストしたい
        -- ここのassertをもっといい感じに書きたい...
        , test "person2" <|
            \() ->
                case person2 of
                    Ok _ ->
                        Ok |> Expect.equal Err

                    Err _ ->
                        Err |> Expect.equal Err
        ]
