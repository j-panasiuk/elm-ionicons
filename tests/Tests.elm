module Tests exposing (..)

import Color
import Expect
import Ionicon.Internal
import Test exposing (..)


all : Test
all =
    describe "Internal" internalTests


internalTests : List Test
internalTests =
    [ describe "fill"
        [ assertEqual "should work for simple colors" "rgb(255,255,255)" <| Ionicon.Internal.fill Color.white
        , assertEqual "should work for RGB colors" "rgb(33,44,55)" <| Ionicon.Internal.fill (Color.rgb 33 44 55)
        , assertEqual "should work for RGBA colors" "rgba(33,44,55,0.5)" <| Ionicon.Internal.fill (Color.rgba 33 44 55 0.5)
        , assertEqual "should trim long alpha values" "rgba(33,44,55,0.333)" <| Ionicon.Internal.fill (Color.rgba 33 44 55 0.33333333)
        ]
    ]


assertEqual : String -> a -> a -> Test
assertEqual description expected actual =
    test description <|
        \() ->
            Expect.equal expected actual
