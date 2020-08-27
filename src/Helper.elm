module Helper exposing (appendToList, cardListToString, cardToIcon, cardToString, ifTrue, msgToString, player1Deck, player2Deck, pluralize, turnToString)

import Types exposing (Card(..), Msg(..), Turn(..))


ifTrue f a b =
    if f then
        a

    else
        b


pluralize : Int -> String -> String
pluralize count text =
    case count of
        1 ->
            "1 " ++ text

        x ->
            (x |> String.fromInt) ++ " " ++ text ++ "s"


appendToList : a -> List a -> List a
appendToList item list =
    List.append list (List.singleton item)



--
-- GAME HELPERS
--


turnToString : Turn -> String
turnToString turn =
    case turn of
        Player1 ->
            "Player 1"

        Player2 ->
            "Player 2"

        GameOver ->
            "Game Over"



--
-- CARD HELPERS
--


cardToIcon : Card -> String
cardToIcon card =
    case card of
        Cow ->
            "./icons/cow.jpg"

        Dog ->
            "./icons/dog.jpg"

        Duck ->
            "./icons/duck.jpg"

        Rooster ->
            "./icons/rooster.jpg"

        Horse ->
            "./icons/horse.jpg"

        Fish ->
            "./icons/fish.jpg"


cardToString : Card -> String
cardToString card =
    case card of
        Cow ->
            "Cow"

        Dog ->
            "Dog"

        Duck ->
            "Duck"

        Rooster ->
            "Rooster"

        Horse ->
            "Horse"

        Fish ->
            "Fish"


cardListToString : List Card -> String
cardListToString list =
    list |> List.map cardToString |> List.intersperse ", " |> List.foldr (++) ""



-- Shuffling will come in another version (not in this demo)


player1Deck : List Card
player1Deck =
    [ Duck, Horse, Dog, Horse, Duck, Fish, Duck, Dog, Rooster, Fish, Cow, Rooster ]


player2Deck : List Card
player2Deck =
    [ Cow, Dog, Fish, Dog, Fish, Horse, Dog, Cow, Duck, Fish, Cow, Rooster ]



-- State Helpers


msgToString : Msg -> String
msgToString msg =
    case msg of
        NoOp ->
            "No Operation"

        TurnCard t ->
            "Turn Card " ++ turnToString t

        Snap t ->
            "Snap " ++ turnToString t

        Replay i ->
            "Replaying to Message " ++ String.fromInt i
