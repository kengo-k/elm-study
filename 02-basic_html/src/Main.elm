-- モジュールMainを定義。モジュール名はファイル名と一致する(Main.elm)
-- メインモジュールはmainという名前の関数をエクスポートする必要がある
-- メインモジュール名はMainである必要はない


module Main exposing (main)

-- HtmlモジュールからHTML型とdiv関数, text関数をインポートする

import Html exposing (..)
import Html.Attributes exposing (class)


createList : List String -> List (Html msg)
createList values =
    List.map (\v -> li [] [ text v ]) values


main : Html msg
main =
    -- div関数は引数としてリストを２つ取る。１つ目が属性のリスト、２つ目は小要素のリストとなる
    div [ class "header" ]
        [ text "Hello, Elm HTML!"
        , ul [] (createList [ "value1", "value2", "value3" ])
        ]
