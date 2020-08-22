module Types exposing (Card(..), Model, Msg(..), Turn(..))


type alias Model =
    { player1 : List Card
    , player2 : List Card
    , pile1 : Maybe Card
    , pile2 : Maybe Card
    , message : String
    , turn : Turn
    , round : Int
    }


type Msg
    = NoOp
    | TurnCard



-- Game


type Turn
    = Player1
    | Player2



-- Cards


type Card
    = Cow
    | Dog
    | Duck
    | Fish
    | Horse
    | Rooster
