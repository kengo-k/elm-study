module Main exposing (..)

import Html exposing (text)
import Json.Decode exposing (decodeString, int, string, succeed)
import Json.Decode.Pipeline exposing (required)


hello : String -> String
hello name =
    "Hello, " ++ name


message : String
message =
    hello "Elm World!!"


sum : Int -> Int -> Int
sum begin end =
    List.foldl (+) 0 (List.range begin end)



-- レコード型のサンプル
-- type alias でレコード型に名前をつけることができる


type alias Person =
    { name : String
    , age : Int
    }


personDecoder : Json.Decode.Decoder Person
personDecoder =
    succeed Person
        |> required "name" string
        |> required "age" int


person1 : Result Json.Decode.Error Person
person1 =
    decodeString personDecoder """{"name": "Yamada", "age": 20}"""


person2 : Result Json.Decode.Error Person
person2 =
    decodeString personDecoder """{"name": "Yamada", "age": "20"}"""



-- レコードを引数に取る関数のサンプル
-- レコードの値を更新した新しいレコードを返す


haveBirthday : Person -> Person
haveBirthday person =
    { name = person.name, age = person.age + 1 }



-- 上記の新しいレコードを返す関数をより簡単に記述する例
-- 更新したい値だけを明示してそれ以外の項目は既存の値をそのまま使うことができる


haveBirthday2 : Person -> Person
haveBirthday2 person =
    { person | age = person.age + 1 }



-- パイプライン関数の例(まずはパイパラインを使わない例)
-- 数値を表現する文字列のリストを合計した値を返す


add1 : Int -> Int
add1 n =
    n + 1


double : Int -> Int
double n =
    n * 2



-- 二倍してから1を足す


doublePlusOne : Int -> Int
doublePlusOne n =
    add1 (double n)


doublePlusOne1 : Int -> Int
doublePlusOne1 n =
    n |> double |> add1


sumstr : List String -> Int
sumstr numStrs =
    List.foldl (+) 0 (List.map (\s -> Maybe.withDefault 0 (String.toInt s)) numStrs)


main : Html.Html msg
main =
    text message
