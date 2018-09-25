# elm-ionicons
The premium icon pack for [Ionic Framework](http://ionicframework.com/) (check out Ionicons website [here](http://ionicons.com/))

## Demo
[Browse all icons here](https://j-panasiuk.github.io/elm-ionicons)

## Overview
Use 700+ SVG ionicons directly in your Elm views. The icons are grouped into:
* Ionicon
* Ionicon.Android
* Ionicon.Ios
* Ionicon.Social

## Installation

### Elm 0.19
```
elm install j-panasiuk/elm-ionicons
```

### Elm 0.18
```
elm package install j-panasiuk/elm-ionicons
```

## Dependencies

### Elm 0.19
- [elm/svg](https://package.elm-lang.org/packages/elm/svg/latest/)

### Elm 0.18
- [elm-lang/svg](https://package.elm-lang.org/packages/elm-lang/svg/latest)

## Example use
Each icon expects size (width and height in pixels) and a color

### Elm 0.19

```elm
import Html exposing (Html, div)
import Ionicon
import Ionicon.Android as Android


main : Html msg
main =
    div []
        [ Ionicon.alert 32 red
        , Android.alarmClock 32 blueish
        ]


-- Define your colors

red : RGBA
red =
    RGBA 1 0 0 1


blueish : RGBA
blueish =
    RGBA 0 0 1 0.5


-- Now that `Color` module is gone from core
-- we just represent color as a record with
-- Float values in 0-1 range

type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }
```

### Elm 0.19 + elm-ui

Here is an example how icons could be used as an elm-ui elements
```elm
import Element exposing (Element, el, html)
import Ionicon.Social as Social


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


type alias Icon msg =
    Int -> RGBA -> Html msg


viewIcon : Icon msg -> Int -> RGBA -> Element msg
viewIcon icon size color =
    el [ centerX, centerY ] <| html <| icon size color


viewLargeGitHubIcon : RGBA -> Element msg
viewLargeGitHubIcon color =
    viewIcon Social.github 80 color
```

### Elm 0.18

```elm
import Html exposing (Html, div)
import Color exposing (Color)
import Ionicon
import Ionicon.Android as Android


main : Html msg
main =
    div []
        [ Ionicon.alert 32 red
        , Android.alarmClock 32 blueish
        ]


-- Define your colors

red : Color
red =
    Color.rgb 255 0 0


blueish : Color
blueish =
    Color.rgba 0 0 255 0.5
```

### Note: SVG icons vs Font icons

You can also use iconicons as a web font by including a css stylesheet, like [link](here).
```html
<link href="https://unpkg.com/ionicons@4.4.2/dist/css/ionicons.min.css" rel="stylesheet">
```
When minified and gzipped these icons weight around 8kB

Before Elm 0.19, using any number of icons from this package meant that code for all 700+ of them was included in your bundle. With 0.19 dead code elimination (`elm make --optimize`) only the icons that are actually used by your project will be included.

Comparing the two approaches, using a stylesheet is a bit more lightweight and doesn't require adding any elm dependencies. On the other hand with this package you don't rely on external css files from CDN. Also you can use all icons as plain old elm functions and forget about css classes (this is particularly nice if you use [mdgriffith/elm-ui](https://github.com/mdgriffith/elm-ui))

## License
MIT

## Thanks
As always, I would like to thank my Mom! :)
