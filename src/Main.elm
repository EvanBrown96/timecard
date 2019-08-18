import Browser
import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Card as Card
import Bootstrap.Navbar as Nav
import Platform.Cmd exposing (Cmd)
import Platform.Sub as Sub exposing (Sub)
import Html.Attributes as Attr

-- main definition
main =
  Browser.element
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- model is currently empty
type alias Model =
  Nav.State

-- no message types yet
type Msg = NavUpdate Nav.State

-- init creates initial state for the navbar
init : () -> (Model, Cmd Msg)
init _ =
  Nav.initialState NavUpdate

-- no subscriptions currently
subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- update function
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    NavUpdate state ->
      (state, Cmd.none)

view : Model -> Html Msg
view model =
  Grid.container
    []
    [ CDN.stylesheet
    , Grid.row
        []
        [ Grid.col
            []
              [ Nav.config NavUpdate
                  |> Nav.secondary
                  |> Nav.items
                      [ Nav.itemLink
                          []
                          [ a
                              [ Attr.href "http://test1" ]
                              [ text "Test 1" ]
                          ]
                      , Nav.itemLinkActive
                          []
                          [ a
                              [ Attr.href "http://current" ]
                              [ text "Current" ]
                          ]
                      ]
                  |> Nav.view model
              ]
        ]
    ]
