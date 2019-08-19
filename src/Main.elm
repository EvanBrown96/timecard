import Browser
import Html exposing (..)
import Bootstrap.CDN as CDN
import Bootstrap.Grid as Grid
import Bootstrap.Grid.Col as Col
import Bootstrap.Grid.Row as Row
import Bootstrap.Card as Card
import Bootstrap.Tab as Tab
import Platform.Cmd exposing (Cmd)
import Platform.Sub as Sub exposing (Sub)
import Html.Attributes as Attr
import List
import TimerGroup exposing (TimerGroup)

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
  { tabState : Tab.State
  , groups   : List TimerGroup
  }

-- no message types yet
type Msg = TabMsg Tab.State

-- init creates initial state for the navbar
init : () -> (Model, Cmd Msg)
init _ =
  let
    initialModel : Model
    initialModel =
      { tabState = Tab.initialState
      , groups   = [
          { name = "hello there joe:::48v\\sd"
          , id = Maybe.withDefault "a" <| TimerGroup.getHtmlId "hello there joe:::48v\\sd"
          }
        ]
      }
  in
  (initialModel, Cmd.none)

-- no subscriptions currently
subscriptions : Model -> Sub Msg
subscriptions _ =
  Sub.none

-- update function
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    TabMsg tabState ->
      let
        updatedTabState : Model
        updatedTabState =
          { model
          | tabState = tabState
          }
      in
      (updatedTabState, Cmd.none)

view : Model -> Html Msg
view model =
  Grid.container
    []
    [ CDN.stylesheet
    , Grid.row
        []
        [ Grid.col
            []
            [ Tab.config TabMsg
                |> Tab.items (List.map createTabItem model.groups)
                |> Tab.view model.tabState
            ]
        ]
    ]

createTabItem : TimerGroup -> Tab.Item Msg
createTabItem timerGroup =
  Tab.item
    { id = timerGroup.id
    , link = Tab.link [] [ text timerGroup.name ]
    , pane = Tab.pane [] [ text "Timers Here" ]
    }
