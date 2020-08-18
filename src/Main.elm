module Main exposing (main)

import Browser
import State exposing (initialModel, update)
import Types exposing (Model, Msg(..))
import View exposing (view)



-- PROGRAM


main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
