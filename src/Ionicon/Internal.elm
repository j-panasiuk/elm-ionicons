module Ionicon.Internal exposing (..)

import Color exposing (Color)
import Html exposing (Html)
import Svg
import Svg.Attributes as A


group__ : List (Color -> Html msg) -> Int -> Color -> Html msg
group__ elements size color =
    svg size
        [ Svg.g [] (List.map (\el -> el color) elements)
        ]


polygon__ : String -> Color -> Html msg
polygon__ points color =
    Svg.polygon
        [ A.points points
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


path__ : String -> Color -> Html msg
path__ d color =
    Svg.path
        [ A.d d
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


circle__ : String -> String -> String -> Color -> Html msg
circle__ cx cy r color =
    Svg.circle
        [ A.cx cx
        , A.cy cy
        , A.r r
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


ellipse__ : String -> String -> String -> String -> Color -> Html msg
ellipse__ cx cy rx ry color =
    Svg.ellipse
        [ A.cx cx
        , A.cy cy
        , A.rx rx
        , A.ry ry
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


rect__ : String -> String -> String -> String -> Color -> Html msg
rect__ x y width height color =
    Svg.rect
        [ A.x x
        , A.y y
        , A.width width
        , A.height height
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


polyline__ : String -> Color -> Html msg
polyline__ points color =
    Svg.polyline
        [ A.points points
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


path : String -> Int -> Color -> Html msg
path shape size color =
    svg size
        [ svgPath shape color
        ]


paths : List String -> Int -> Color -> Html msg
paths shapes size color =
    svg size
        [ Svg.g [] (List.map (\shape -> svgPath shape color) shapes)
        ]


polygon : String -> Int -> Color -> Html msg
polygon points size color =
    svg size
        [ svgPolygon points color
        ]


polygons : List String -> Int -> Color -> Html msg
polygons group size color =
    svg size
        [ Svg.g [] (List.map (\points -> svgPolygon points color) group)
        ]


rect : String -> String -> String -> String -> Int -> Color -> Html msg
rect x y width height size color =
    svg size
        [ Svg.rect
            [ A.x x
            , A.y y
            , A.width width
            , A.height height
            , A.fill (toRgbaString (Color.toRgb color))
            ]
            []
        ]


svg size =
    Svg.svg
        [ A.version "1.1"
        , A.x "0px"
        , A.y "0px"
        , A.width (toString size)
        , A.height (toString size)
        , A.viewBox "0 0 512 512"
        , A.enableBackground "new 0 0 512 512"
        ]


svgPath shape color =
    Svg.path
        [ A.d shape
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


svgPolygon points color =
    Svg.polygon
        [ A.points points
        , A.fill (toRgbaString (Color.toRgb color))
        ]
        []


toRgbaString : { red : Int, green : Int, blue : Int, alpha : Float } -> String
toRgbaString { red, green, blue } =
    "rgb(" ++ String.join "," (List.map toString [ red, green, blue ]) ++ ")"
