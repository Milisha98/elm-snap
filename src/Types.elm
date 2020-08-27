module Types exposing (Card(..), Model, Msg(..), Turn(..))


type alias Model =
    { player1 : List Card
    , player2 : List Card
    , pile1 : List Card
    , pile2 : List Card
    , message : String
    , turn : Turn
    , round : Int
    , history : List Msg
    }


type Msg
    = NoOp
    | TurnCard Turn
    | Snap Turn
    | Replay Int



-- Game


type Turn
    = Player1
    | Player2
    | GameOver



-- Cards


type Card
    = Cow
    | Dog
    | Duck
    | Fish
    | Horse
    | Rooster
