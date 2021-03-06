module View exposing (view)

import Helper exposing (cardToIcon, ifTrue)
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
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
            , div [ class "row" ] [ viewState model ]
            ]
        ]


viewPlayer : Turn -> Model -> Html Msg
viewPlayer player model =
    let
        playerCards =
            ifTrue (player == Player1) model.player1 model.player2

        cmd =
            ifTrue (player == model.turn) (TurnCard player) NoOp

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
        , div [ class "row" ] [ hr [] [] ]
        , div [ class "row" ] [ button [ class "card-width", onClick (Snap player) ] [ text "SNAP!" ] ]
        , div [ class "row" ] [ div [ class "col-sm-12" ] [ (playerCards |> List.length |> String.fromInt) ++ " cards remaining" |> text ] ]
        ]


viewMessages : Model -> Html Msg
viewMessages model =
    div [ class "container form-box" ]
        [ div [ class "row form-box-bottom" ] [ h2 [ class "form-label" ] [ text "Messages" ] ]
        , div [ class "container" ] (model.history |> List.indexedMap Tuple.pair |> List.map viewMessage)
        ]


viewMessage : ( Int, Msg ) -> Html Msg
viewMessage ( index, msg ) =
    div [ class "row" ] [ div [ class "col-sm-12" ] [ a [ onClick (Replay index) ] [ msg |> Helper.msgToString |> text ] ] ]


viewGameArea : Model -> Html Msg
viewGameArea model =
    div [ class "container game-area" ]
        [ div [ class "row" ]
            [ div [ class "col-sm-6" ] [ model.pile1 |> List.head |> Maybe.map viewCard |> Maybe.withDefault viewEmptyPile ]
            , div [ class "col-sm-6" ] [ model.pile2 |> List.head |> Maybe.map viewCard |> Maybe.withDefault viewEmptyPile ]
            ]
        , div [ class "row" ] [ div [ class "col-sm-12 game-message" ] [ text model.message ] ]
        ]


viewState : Model -> Html Msg
viewState model =
    div [ class "col-sm-12 container" ]
        [ div [ class "row form-box-bottom" ]
            [ div [ class "col-sm-1 form-label" ] [ text "Round:" ]
            , div [ class "col-sm font-small form-box-right" ] [ model.round |> String.fromInt |> text ]
            ]
        , div [ class "row form-box-bottom" ]
            [ div [ class "col-sm-1 form-label" ] [ text "Turn:" ]
            , div [ class "col-sm font-small form-box-right" ] [ model.turn |> Helper.turnToString |> text ]
            ]
        , div [ class "row form-box-bottom" ]
            [ div [ class "col-sm-1 form-label" ] [ text "Player 1:" ]
            , div [ class "col-sm font-small form-box-right" ] [ model.player1 |> Helper.cardListToString |> text ]
            ]
        , div [ class "row form-box-bottom" ]
            [ div [ class "col-sm-1 form-label" ] [ text "Player 2:" ]
            , div [ class "col-sm font-small form-box-right" ] [ model.player2 |> Helper.cardListToString |> text ]
            ]
        , div [ class "row form-box-bottom" ]
            [ div [ class "col-sm-1 form-label" ] [ text "Pile:" ]
            , div [ class "col-sm font-small form-box-right" ] [ model.pile2 |> List.append model.pile1 |> Helper.cardListToString |> text ]
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


viewCardBackInactive : Html Msg
viewCardBackInactive =
    div [ class "game-card" ]
        [ div [ class "back-of-card-inactive" ] [] ]


viewPile : Msg -> Html Msg
viewPile msg =
    let
        card =
            case msg of
                TurnCard p ->
                    viewCardBack msg

                _ ->
                    viewCardBackInactive
    in
    div [ class "game-card" ]
        [ div [ class "game-card pile" ] [ card ]
        ]


viewEmptyPile : Html Msg
viewEmptyPile =
    div [ class "empty-pile" ] []
