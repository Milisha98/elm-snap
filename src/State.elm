module State exposing (initialModel, update)

import Helper exposing (appendToList)
import Types exposing (Card(..), Model, Msg(..), Turn(..))



--
-- INITIAL
--


initialModel : Model
initialModel =
    { player1 = Helper.player1Deck
    , player2 = Helper.player2Deck
    , pile1 = []
    , pile2 = []
    , message = "Welcome! Player 1 to start."
    , turn = Player1
    , round = 1
    , history = []
    }



--
-- UPDATE
--


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        TurnCard _ ->
            model
                |> addMessage msg
                |> turnCard
                |> changeTurns

        Snap player ->
            model
                |> addMessage msg
                |> snap player

        Replay index ->
            model
                |> replayToMessage index



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
                | pile1 = model.pile1 |> List.append (model.player1 |> List.take 1)
                , player1 = model.player1 |> removeFromStack
            }

        Player2 ->
            { model
                | pile2 = model.pile2 |> List.append (model.player2 |> List.take 1)
                , player2 = model.player2 |> removeFromStack
            }

        GameOver ->
            model


changeTurns : Model -> Model
changeTurns model =
    let
        newTurn =
            if model.turn == Player1 then
                Player2

            else
                Player1

        newRound =
            if model.turn == Player1 then
                model.round

            else
                model.round + 1

        checkGameOver m =
            case ( m.player1, m.player2 ) of
                ( [], _ ) ->
                    { m | turn = GameOver, message = "Player 2 Wins!" }

                ( _, [] ) ->
                    { m | turn = GameOver, message = "Player 1 Wins!" }

                ( _, _ ) ->
                    m
    in
    { model
        | turn = newTurn
        , message = Helper.turnToString newTurn ++ "'s Turn"
        , round = newRound
    }
        |> checkGameOver


snap : Turn -> Model -> Model
snap who model =
    let
        isSnap =
            List.head model.pile1 /= Nothing && List.head model.pile1 == List.head model.pile2

        addPile pile =
            pile |> List.append model.pile1 |> List.append model.pile2
    in
    if isSnap then
        case who of
            Player1 ->
                { model
                    | player1 = model.player1 |> addPile
                    , pile1 = []
                    , pile2 = []
                    , message = "Player 1 wins that round."
                }

            Player2 ->
                { model
                    | player2 = model.player2 |> addPile
                    , pile1 = []
                    , pile2 = []
                    , message = "Player 2 wins that round."
                }

            GameOver ->
                model

    else
        model



--
-- State Functions
--


addMessage : Msg -> Model -> Model
addMessage msg model =
    { model | history = model.history |> appendToList msg }


replayToMessage : Int -> Model -> Model
replayToMessage index model =
    model.history
        |> List.take index
        |> List.foldl update initialModel
