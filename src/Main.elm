import Browser
import Html exposing (..)

-- main definition
main =
  Browser.sandbox
    { init = ()
    , view = view
    , update = update
    }

-- model is currently empty
type alias Model =
  ()

-- no message types yet
type alias Msg =
  ()

-- update does nothing currently
update : Msg -> Model -> Model
update _ _ =
  ()

view : Model -> Html Msg
view _ =
  text "nothing here yet"
