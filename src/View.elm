module View exposing (view)

import Helper exposing (cardToIcon)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Types exposing (Card(..), Model, Msg(..))


view : Model -> Html Msg
view model =
    div [ class "fit-content" ]
        [ div [ class "header" ] [ h2 [] [ text "Ultimate Snap Premiership League" ] ]
        , viewPile NoOp
        , viewCard Horse
        ]


viewCard : Card -> Html Msg
viewCard card =
    div [ class "game-card" ] [ Html.img [ card |> Helper.cardToIcon |> Html.Attributes.src ] [] ]


viewCardBack : Msg -> Html Msg
viewCardBack msg =
    div [ class "game-card", onClick msg ]
        [ div [ class "back-of-card" ] [] ]


viewPile : Msg -> Html Msg
viewPile msg =
    div [ class "game-card", onClick msg ]
        [ div [ class "game-card pile" ] [ viewCardBack msg ]
        ]
