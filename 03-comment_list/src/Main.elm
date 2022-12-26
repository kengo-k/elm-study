module Main exposing (main)

-- HtmlモジュールからHTML型とdiv関数, text関数をインポートする

import Browser
import Html exposing (..)
import Html.Attributes exposing (type_, value)
import Html.Events exposing (onClick, onInput)
import String exposing (trim)


type alias Model =
    { comments : List String
    , newComment : String
    }


type Message
    = UpdateComment String
    | SaveComment


update : Message -> Model -> Model
update message model =
    case message of
        UpdateComment newComment ->
            { model | newComment = newComment }

        SaveComment ->
            case String.trim model.newComment of
                "" ->
                    model

                newComment ->
                    { model | comments = model.comments ++ [ newComment ], newComment = "" }


view : Model -> Html Message
view model =
    div []
        [ viewCommentList model.comments
        , input [ type_ "text", onInput UpdateComment, value model.newComment ] []
        , button [ onClick SaveComment ] [ text "Save" ]
        ]


viewCommentList : List String -> Html Message
viewCommentList comments =
    ul [] (List.map viewComment comments)


viewComment : String -> Html Message
viewComment comment =
    li [] [ text comment ]


main : Program () Model Message
main =
    Browser.sandbox
        { init = { comments = [], newComment = "" }
        , update = update
        , view = view
        }
