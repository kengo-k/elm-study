module Main exposing (..)

import Html exposing (text)


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


main : Html.Html msg
main =
    text message
