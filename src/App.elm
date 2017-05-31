module App exposing (..)

import Html exposing (Attribute, Html, input, text, div, node, em)
import Html.Attributes exposing (attribute, src, value, class)
import Html.Events exposing (on, onInput, targetValue)
import Json.Decode as Json


---- MODEL ----


type alias Model =
    { salutation : String
    }


init : String -> ( Model, Cmd Msg )
init path =
    ( { salutation = "ElmPrague" }, Cmd.none )



---- UPDATE ----


type Msg
    = NewSalutation String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NewSalutation salutation ->
            ( { model | salutation = salutation }, Cmd.none )



---- VIEW ----


onUpdateSalutation : Attribute Msg
onUpdateSalutation =
    on "update-salutation" <| (Json.map NewSalutation (Json.at [ "target", "_eventData" ] Json.string))


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ div [] [ em [] [ text "This is rendered using Elm" ] ]
            , text "model.salutation: "
            , input [ value model.salutation, onInput NewSalutation, class "elmInput" ] []
            ]
        , node "hello-element" [ attribute "salutation" model.salutation, onUpdateSalutation ] []
        ]



---- PROGRAM ----


main : Program String Model Msg
main =
    Html.programWithFlags
        { view = view
        , init = init
        , update = update
        , subscriptions = \_ -> Sub.none
        }
