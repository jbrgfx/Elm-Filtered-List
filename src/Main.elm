module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL


type alias Model =
    { people : List String
    , results : List String
    , filter : String
    }


model : Model
model =
    { people = [ "Alice", "Jill", "Joan", "Joanne", "Zoe" ]
    , results = [ "Jill", "Joan", "Joanne" ]
    , filter = "J"
    }



-- UPDATE


type Msg
    = Filter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filter ->
            { model
                | results = List.filter (String.contains filter) model.people
                , filter = filter
            }



-- VIEW


view : Model -> Html Msg
view model =
    div []
        [ label [] [ text " Filter: " ]
        , input [ placeholder model.filter, onInput Filter ] []

        -- , button [ onClick Add ] [ text "Add New" ]
        , p [] [ text "Entries :" ]
        , ul [] (List.map viewEntry model.people)
        , p [] [ text "Filter: " ]
        , p [] [ text model.filter ]
        , p [] [ text "Filtered:" ]
        , ul [] (List.map viewEntry model.results)
        ]


viewEntry : String -> Html Msg
viewEntry entry =
    li [] [ text entry ]
