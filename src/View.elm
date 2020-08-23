module View exposing (view)

import Helper exposing (cardToIcon, ifTrue)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick, onInput)
import Types exposing (Card(..), Model, Msg(..), Turn(..))


view : Model -> Html Msg
view model =
    div [ class "fit-content" ]
        [ div [ class "header" ] [ h1 [] [ text "Ultimate Snap Premiership League" ] ]
        , div [ class "container game" ]
            [ div [ class "row" ]
                [ div [ class "col-sm-3" ] [ viewPlayer Player1 model ]
                , div [ class "col-sm-4" ] [ viewGameArea model ]
                , div [ class "col-sm-3" ] [ viewPlayer Player2 model ]
                , div [ class "col-sm-2" ] [ viewMessages model ]
                ]
            ]
        , div [ class "container" ]
            [ div [ class "row form-box-bottom" ] [ h2 [ class "form-label" ] [ text "Model" ] ]
            , div [ class "row" ] []
            ]

        -- , viewPile NoOp
        -- , viewCard Horse
        ]


viewPlayer : Turn -> Model -> Html Msg
viewPlayer player model =
    let
        playerCards =
            ifTrue (player == Player1) model.player1 model.player2

        cmd =
            ifTrue (player == model.turn) TurnCard NoOp

        show =
            case playerCards of
                [] ->
                    viewEmptyPile

                _ ->
                    viewPile cmd
    in
    div [ class "container" ]
        [ div [ class "row form-box-bottom" ] [ h2 [ class "form-label" ] [ player |> Helper.turnToString |> text ] ]
        , div [ class "row" ] [ show ]
        , div [ class "row" ] [ button [ class "card-width", onClick (Snap player) ] [ text "SNAP!" ] ]
        ]


viewMessages : Model -> Html Msg
viewMessages model =
    div [ class "container form-box" ]
        [ div [ class "row form-box-bottom" ] [ h2 [ class "form-label" ] [ text "Messages" ] ]
        ]


viewGameArea : Model -> Html Msg
viewGameArea model =
    div [ class "container game-area" ]
        [ div [ class "row" ]
            [ div [ class "col-sm-6" ] [ model.pile1 |> Maybe.map viewCard |> Maybe.withDefault viewEmptyPile ]
            , div [ class "col-sm-6" ] [ model.pile2 |> Maybe.map viewCard |> Maybe.withDefault viewEmptyPile ]
            ]
        ]



--
-- LOWER LEVEL VIEW FUNCTIONS
--


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


viewEmptyPile : Html Msg
viewEmptyPile =
    div [ class "empty-pile" ] []
