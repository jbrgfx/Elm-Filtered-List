module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main =
    Html.beginnerProgram { model = model, view = view, update = update }



-- MODEL
-- type alias Model
--   {filtered = Filtered}


type alias Model =
    { people : List String
    , results : List String
    , filter : String
    }


model : Model
model =
    { people = [ "Alice", "Jill", "Joan", "Joanne", "Zoe" ]
    , results = [ "Jill", "Joan", "Joanne" ]
    , filter = "Jo"
    }


type Status
    = NoStatus
    | FilterSet



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
        [ p [] [ text "Filtering is 'case-sensative.'" ]
        , label [] [ text " Filter: " ]
        , input [ placeholder model.filter, onInput Filter ] []
        , p [] [ text "Filter: " ]
        , p [] [ text model.filter ]
        , p [] [ text "Filtered:" ]
        , ul [] (List.map viewEntry model.results)
        , p [] [ text "Entries :" ]
        , ul [] (List.map viewEntry model.people)
        ]


viewEntry : String -> Html Msg
viewEntry entry =
    li [] [ text entry ]
