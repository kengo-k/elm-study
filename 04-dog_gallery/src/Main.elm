module Main exposing (..)

-- HtmlモジュールからHTML型とdiv関数, text関数をインポートする

import Browser
import Html exposing (..)
import Html.Attributes exposing (src)
import Http
import Json.Decode exposing (string, succeed)
import Json.Decode.Pipeline exposing (required)


type alias Dog =
    { message : String, status : String }


type alias Model =
    { dog : Maybe Dog }


type Message
    = Load (Result Http.Error Dog)


dogDecoder : Json.Decode.Decoder Dog
dogDecoder =
    succeed Dog
        |> required "message" string
        |> required "status" string


fetch : Cmd Message
fetch =
    Http.get
        { url = "https://dog.ceo/api/breeds/image/random"
        , expect = Http.expectJson Load dogDecoder
        }


update : Message -> Model -> ( Model, Cmd Message )
update msg model =
    case msg of
        Load (Ok dog) ->
            ( { model | dog = Just dog }, Cmd.none )

        Load (Err _) ->
            ( model, Cmd.none )


view : Model -> Html Message
view model =
    case model.dog of
        Just dog ->
            viewDog dog

        Nothing ->
            div [] [ text "Loading..." ]


viewDog : Dog -> Html Message
viewDog dog =
    div [] [ img [ src dog.message ] [] ]


subscriptions : Model -> Sub Message
subscriptions _ =
    Sub.none


init : () -> ( Model, Cmd Message )
init () =
    ( { dog = Nothing }, fetch )


main : Program () Model Message
main =
    Browser.element
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }
