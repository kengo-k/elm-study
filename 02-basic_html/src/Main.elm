module Main exposing(main)

-- HtmlモジュールからHTML型とdiv関数, text関数をインポートする
import Html exposing (Html, div, text)

main : Html msg
main =
  -- div関数は引数としてリストを２つ取る。１つ目が属性のリスト、２つ目は小要素のリストとなる
  div [] [ text "Hello, Elm HTML!"]
