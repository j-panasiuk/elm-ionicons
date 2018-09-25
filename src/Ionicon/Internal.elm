module Ionicon.Internal exposing (RGBA, c3, e4, fill, g, p, p1, pg, pg1, pgs, pl1, ps, pst, pt, r, r4, r4t)

import Html exposing (Html)
import Svg exposing (Svg)
import Svg.Attributes as A



-- COLORS


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }



-- CONSTRUCT ICONS


{-| Build icon from svg path shape
-}
p : String -> Int -> RGBA -> Html msg
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
ps : List String -> Int -> RGBA -> Html msg
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
pg : String -> Int -> RGBA -> Html msg
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
pgs : List String -> Int -> RGBA -> Html msg
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
r : String -> String -> String -> String -> Int -> RGBA -> Html msg
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
g : List (RGBA -> Html msg) -> Int -> RGBA -> Html msg
g elements size color =
    svg size
        [ Svg.g [] (List.map (\el -> el color) elements)
        ]



-- COSTRUCT + TRANSFORM ICONS


{-| Build icon from transformed path
-}
pt : String -> String -> Int -> RGBA -> Html msg
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
pst : List String -> String -> Int -> RGBA -> Html msg
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
p1 : String -> RGBA -> Html msg
p1 d color =
    Svg.path
        [ A.d d
        , A.fill (fill color)
        ]
        []


{-| Icon part - polygon
-}
pg1 : String -> RGBA -> Html msg
pg1 points color =
    Svg.polygon
        [ A.points points
        , A.fill (fill color)
        ]
        []


{-| Icon part - polyline
-}
pl1 : String -> RGBA -> Html msg
pl1 points color =
    Svg.polyline
        [ A.points points
        , A.fill (fill color)
        ]
        []


{-| Icon part - circle
-}
c3 : String -> String -> String -> RGBA -> Html msg
c3 cx cy radius color =
    Svg.circle
        [ A.cx cx
        , A.cy cy
        , A.r radius
        , A.fill (fill color)
        ]
        []


{-| Icon part - ellipse
-}
e4 : String -> String -> String -> String -> RGBA -> Html msg
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
r4 : String -> String -> String -> String -> RGBA -> Html msg
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
r4t : String -> String -> String -> String -> String -> RGBA -> Html msg
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
        , A.width (String.fromInt size)
        , A.height (String.fromInt size)
        , A.viewBox "0 0 512 512"
        , A.enableBackground "new 0 0 512 512"
        ]


fill : RGBA -> String
fill { red, green, blue, alpha } =
    let
        ( colorSpace, values ) =
            if 0 <= alpha && alpha < 1 then
                ( "rgba"
                , [ red |> toColorString
                  , green |> toColorString
                  , blue |> toColorString
                  , alpha |> toAlphaString
                  ]
                )

            else
                ( "rgb"
                , [ red |> toColorString
                  , green |> toColorString
                  , blue |> toColorString
                  ]
                )
    in
    colorSpace ++ "(" ++ String.join "," values ++ ")"


toColorString : Float -> String
toColorString value =
    value
        |> (*) 255
        |> clamp 0 255
        |> String.fromFloat
        |> String.left 5


toAlphaString : Float -> String
toAlphaString value =
    value
        |> clamp 0 1
        |> String.fromFloat
        |> String.left 5
