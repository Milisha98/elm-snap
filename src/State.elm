module State exposing (initialModel, update)

import Helper exposing (ifTrue)
import Types exposing (Model, Msg(..), Turn(..))



--
-- INITIAL
--


initialModel : Model
initialModel =
    { player1 = []
    , player2 = []
    , pile1 = Maybe.Nothing
    , pile2 = Maybe.Nothing
    , message = "Welcome! Player 1 to start."
    , turn = Player1
    , round = 1
    }



--
-- UPDATE
--


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        TurnCard ->
            model
                |> turnCard
                |> changeTurns



--
-- GAME-PLAY FUNCTIONS
--


turnCard : Model -> Model
turnCard model =
    let
        removeFromStack stack =
            stack |> List.tail |> Maybe.withDefault []
    in
    case model.turn of
        Player1 ->
            { model
                | pile1 = model.player1 |> List.head
                , player1 = model.player1 |> removeFromStack
            }

        Player2 ->
            { model
                | pile2 = model.player2 |> List.head
                , player2 = model.player2 |> removeFromStack
            }


changeTurns : Model -> Model
changeTurns model =
    let
        newTurn =
            ifTrue (model.turn == Player1) Player2 Player1

        newRound =
            ifTrue (model.turn == Player1) model.round (model.round + 1)
    in
    { model
        | turn = newTurn
        , message = Helper.turnToString newTurn ++ "'s Turn"
        , round = newRound
    }
