module View exposing (View, map, readme)

import Html exposing (Html, div)


type alias View msg =
    { title : String
    , body : List (Html msg)
    }


map : (msg1 -> msg2) -> View msg1 -> View msg2
map fn doc =
    { title = doc.title
    , body = List.map (Html.map fn) doc.body
    }


readme : List (Html msg) -> View msg
readme html =
    { title = "Evan Piro"
    , body = [ div [] html ]
    }
