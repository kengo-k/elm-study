module Main exposing (main, sum)

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


main : Html.Html msg
main =
    text message
