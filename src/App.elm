module App exposing (..)

import Html exposing (Attribute, Html, br, input, text, div, node, em, h1)
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


onSetSalutation : Attribute Msg
onSetSalutation =
    on "set-salutation" <| (Json.map NewSalutation (Json.at [ "target", "_eventData" ] Json.string))


view : Model -> Html Msg
view model =
    div []
        [ div []
            [ div [] [ em [] [ text "This is rendered using Elm" ] ]
            , text "model.salutation: "
            , input [ value model.salutation, onInput NewSalutation, class "elmInput" ] []
            , br [] []
            , node "hello-the-second"
                [ attribute "salutation" (model.salutation ++ " ---------")
                , onSetSalutation
                ]
                []
            , h1 [] [ text "Hello H1" ]
            , node "hello-the-second"
                [ attribute "salutation" model.salutation
                , onSetSalutation
                ]
                []
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
