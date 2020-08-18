module State exposing (initialModel, update)

import Helper
import Types exposing (Model, Msg(..), Turn(..))



--
-- INITIAL
--


initialModel : Model
initialModel =
    { player1 = []
    , player2 = []
    , pile = []
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
