module Main exposing (..)

import Color exposing (black, darkBlue, lightGrey, white)
import Element exposing (Element, alignBottom, alignLeft, centerY, column, height, image, layout, newTabLink, padding, paddingEach, paragraph, px, row, text, width)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Html


main =
    Html.beginnerProgram { model = initialModel, view = view, update = update }


type alias Model =
    { people : List String
    , filtered : List String
    , filterTerm : String
    }


initialModel : Model
initialModel =
    { people = [ "Alice", "Anne", "Jane", "Joan", "Joanne", "Zane", "Zoe" ]
    , filtered = [ "Anne", "Jane", "Joanne", "Zane" ]
    , filterTerm = "ne"
    }



-- UPDATE


type Msg
    = Filter String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Filter filterTerm ->
            { model
                | filtered = List.filter (String.contains filterTerm) model.people
                , filterTerm = filterTerm
            }


view model =
    Element.layout
        [ Background.color white
        , width (px 900)
        , paddingLeft gutter
        ]
    <|
        column
            []
            [ headerArea
            , mainColumns
                { left =
                    [ row [ padding gutter ] [ inputForm ]
                    , validateFilter model
                    , paragraph
                        []
                        [ text "Results:" ]
                    , paragraph
                        [ padding gutter
                        , Background.color lightGrey
                        ]
                        (List.map viewPeople model.filtered)
                    ]
                , right =
                    [ overViewDesc ]
                }
            , footerArea
            ]


overViewDesc =
    paragraph
        [ padding gutter
        , Element.alignTop
        ]
        [ Element.el
            [ alignLeft
            , Element.spacingXY 4 100
            , padding 10
            , Font.size 40
            , Font.lineHeight 1
            , Font.color darkBlue
            , Background.color white
            ]
            (text "A")
        , paragraph
            [ width (px 300)
            , Font.color black
            , Font.size 18
            ]
            [ text " simple Elm module that filters a list using text input.  The module has an initial state to demonstrate to the end-user how the text box works and end-user feedback to guide the user in the use of the module." ]
        ]


viewPeople entry =
    paragraph
        []
        [ Element.text entry
        ]


validateFilter model =
    let
        message =
            if model.filterTerm == "" then
                "❌ No filter. Try adding one!"
            else
                "✅ Filter is set."
    in
    row []
        [ text message ]


mainColumns { left, right } =
    row
        [ borderBottom 1
        , Border.color darkBlue
        ]
        [ column
            [ borderRight 1
            , Border.color darkBlue
            , paddingRight gutter
            ]
            left
        , column
            [ paddingLeft gutter ]
            right
        ]


inputForm : Element Msg
inputForm =
    Input.text
        [ Border.color Color.black
        ]
        { label = Input.labelLeft [] (text "Filter:")
        , onChange = Just Filter
        , placeholder = Nothing
        , text = initialModel.filterTerm
        }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Atom.elm -}


gutter =
    20



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


borderRight n =
    Border.widthEach { right = n, left = 0, top = 0, bottom = 0 }


borderBottom n =
    Border.widthEach { right = 0, left = 0, top = 0, bottom = n }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingRight n =
    paddingEach { right = n, left = 0, top = 0, bottom = 0 }


paddingTop n =
    paddingEach { bottom = 0, top = n, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingBottom n =
    paddingEach { bottom = n, top = 0, left = 0, right = 0 }



{- credit: https://github.com/opsb/cv-elm/blob/master/src/Extra/Element.elm -}


paddingLeft n =
    paddingEach { right = 0, left = n, top = 0, bottom = 0 }


headerArea =
    row
        [ Background.color white
        , Font.color darkBlue
        , borderBottom 1
        , Border.color darkBlue
        ]
        [ elmlogo
        , newTabLink
            [ padding gutter
            , Font.bold
            , Font.size 18
            , Font.underline
            , alignBottom
            ]
            { url = "http://package.elm-lang.org/packages/mdgriffith/stylish-elephants/4.0.0"
            , label = Element.text "stylish-elephants: package docs"
            }
        ]


elmlogo =
    row []
        [ image
            [ width (px 180)
            , height (px 73)
            , alignLeft
            ]
            { description = "the Elm Language logo"
            , src = "elm_logo_small.png"
            }
        ]


footerArea =
    row
        [ Font.color darkBlue
        , paddingTop 20
        ]
        [ newTabLink
            [ Font.bold
            , Font.underline
            , Font.size 16
            , centerY
            ]
            { url = "https://github.com/jbrgfx"
            , label = Element.text "jbrgfx's github repos."
            }
        ]
