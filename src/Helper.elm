module Helper exposing (cardToIcon, cardToString, ifTrue, pluralize, turnToString)

import Types exposing (Card(..), Turn(..))


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
