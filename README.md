# elm-ionicons
The premium icon font for [Ionic Framework](http://ionicframework.com/). Now available in Elm!

[Ionicons website](http://ionicons.com/)

[GitHub page](https://github.com/ionic-team/ionicons)

## Overview
**elm-ionicons** allows you to use 733 scalable vector ionicons directly in your Elm views. The icons are grouped in four modules:
* Ionicon
* Ionicon.Android
* Ionicon.Ios
* Ionicon.Social

## Installation
```
elm package install j-panasiuk/elm-ionicons
```

## Example use
Each icon takes two arguments
1) size in pixels : *Int*
2) color : as defined in [elm-lang/core](http://package.elm-lang.org/packages/elm-lang/core/latest/Color)
```elm
module MyIcons exposing (..)

import Html exposing (Html, div)
import Color
import Ionicon
import Ionicon.Android as Android


main : Html msg
main =
    div []
        [ Ionicon.alert 32 Color.red
        , Android.alarmClock 32 Color.blue
        ]
```

## Related packages
* [elm-community/material-icons](https://github.com/elm-community/material-icons)
* [jystic/elm-font-awesome](https://github.com/jystic/elm-font-awesome)
* [capitalist/elm-octicons](https://github.com/capitalist/elm-octicons)
