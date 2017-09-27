module Ionicon.Internal exposing (c3, e4, g, p, p1, pg, pg1, pgs, pl1, ps, pst, pt, r, r4, r4t)

import Color exposing (Color)
import Html exposing (Html)
import Svg exposing (Svg)
import Svg.Attributes as A


-- CONSTRUCT ICONS


{-| Build icon from svg path shape
-}
p : String -> Int -> Color -> Html msg
p d size color =
    svg size
        [ Svg.path
            [ A.d d
            , A.fill (fill color)
            ]
            []
        ]


{-| Build icon from a bunch of path shapes
-}
ps : List String -> Int -> Color -> Html msg
ps ds size color =
    svg size
        [ Svg.g [] <|
            List.map
                (\d ->
                    Svg.path
                        [ A.d d
                        , A.fill (fill color)
                        ]
                        []
                )
                ds
        ]


{-| Build icon from svg polygon points
-}
pg : String -> Int -> Color -> Html msg
pg points size color =
    svg size
        [ Svg.polygon
            [ A.points points
            , A.fill (fill color)
            ]
            []
        ]


{-| Build icon from a bunch of polygon point groups
-}
pgs : List String -> Int -> Color -> Html msg
pgs groupsOfPoints size color =
    svg size
        [ Svg.g [] <|
            List.map
                (\points ->
                    Svg.polygon
                        [ A.points points
                        , A.fill (fill color)
                        ]
                        []
                )
                groupsOfPoints
        ]


{-| Build icon from svg rectangle params
-}
r : String -> String -> String -> String -> Int -> Color -> Html msg
r x y width height size color =
    svg size
        [ Svg.rect
            [ A.x x
            , A.y y
            , A.width width
            , A.height height
            , A.fill (fill color)
            ]
            []
        ]


{-| Build icon from a bunch of separate parts
-}
g : List (Color -> Html msg) -> Int -> Color -> Html msg
g elements size color =
    svg size
        [ Svg.g [] (List.map (\el -> el color) elements)
        ]



-- COSTRUCT + TRANSFORM ICONS


{-| Build icon from transformed path
-}
pt : String -> String -> Int -> Color -> Html msg
pt d transform size color =
    svg size
        [ Svg.path
            [ A.d d
            , A.transform transform
            , A.fill (fill color)
            ]
            []
        ]


{-| Build icon from a bunch of transformed paths
-}
pst : List String -> String -> Int -> Color -> Html msg
pst ds transform size color =
    svg size
        [ Svg.g [] <|
            List.map
                (\d ->
                    Svg.path
                        [ A.d d
                        , A.transform transform
                        , A.fill (fill color)
                        ]
                        []
                )
                ds
        ]



-- ICON PARTS


{-| Icon part - path
-}
p1 : String -> Color -> Html msg
p1 d color =
    Svg.path
        [ A.d d
        , A.fill (fill color)
        ]
        []


{-| Icon part - polygon
-}
pg1 : String -> Color -> Html msg
pg1 points color =
    Svg.polygon
        [ A.points points
        , A.fill (fill color)
        ]
        []


{-| Icon part - polyline
-}
pl1 : String -> Color -> Html msg
pl1 points color =
    Svg.polyline
        [ A.points points
        , A.fill (fill color)
        ]
        []


{-| Icon part - circle
-}
c3 : String -> String -> String -> Color -> Html msg
c3 cx cy r color =
    Svg.circle
        [ A.cx cx
        , A.cy cy
        , A.r r
        , A.fill (fill color)
        ]
        []


{-| Icon part - ellipse
-}
e4 : String -> String -> String -> String -> Color -> Html msg
e4 cx cy rx ry color =
    Svg.ellipse
        [ A.cx cx
        , A.cy cy
        , A.rx rx
        , A.ry ry
        , A.fill (fill color)
        ]
        []


{-| Icon part - rect
-}
r4 : String -> String -> String -> String -> Color -> Html msg
r4 x y width height color =
    Svg.rect
        [ A.x x
        , A.y y
        , A.width width
        , A.height height
        , A.fill (fill color)
        ]
        []


{-| Icon part - rect with transform
-}
r4t : String -> String -> String -> String -> String -> Color -> Html msg
r4t x y width height transform color =
    Svg.rect
        [ A.x x
        , A.y y
        , A.width width
        , A.height height
        , A.transform transform
        , A.fill (fill color)
        ]
        []



-- HELPERS


svg : Int -> List (Svg msg) -> Html msg
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


fill : Color -> String
fill =
    toRgbaString << Color.toRgb


toRgbaString : { red : Int, green : Int, blue : Int, alpha : Float } -> String
toRgbaString { red, green, blue, alpha } =
    let
        ( rgba, values ) =
            if alpha < 1 then
                ( "rgba", [ toString red, toString green, toString blue, String.left 5 (toString alpha) ] )
            else
                ( "rgb", [ toString red, toString green, toString blue ] )
    in
    rgba ++ "(" ++ String.join "," values ++ ")"
