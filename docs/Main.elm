module Main exposing (main)

import Browser
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Keyed as Keyed
import Html exposing (Html)
import Ionicon
import Ionicon.Android as Android
import Ionicon.Ios as Ios
import Ionicon.Social as Social
import Tuple exposing (pair)


main : Program () Model Msg
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }



-- MODEL


type alias Model =
    { searchPhrase : String
    }


initialModel : Model
initialModel =
    { searchPhrase = ""
    }



-- UPDATE


type Msg
    = Search String


update : Msg -> Model -> Model
update msg model =
    case msg of
        Search phrase ->
            { model | searchPhrase = phrase }



-- VIEW


view : Model -> Html Msg
view model =
    Element.layout [ Background.color (rgb 0.98 0.98 0.98) ] <|
        column [ width fill ] <|
            [ viewHeader
            , viewControls model
            , row [ width fill ]
                [ viewIconGroup "Ionicon" ionicons model
                , viewIconGroup "Ionicon.Android" androidIcons model
                , viewIconGroup "Ionicon.Ios" iosIcons model
                , viewIconGroup "Ionicon.Social" socialIcons model
                ]
            ]


viewHeader : Element msg
viewHeader =
    row
        [ width fill
        , paddingXY 15 5
        , Font.bold
        , Font.color (rgb01 greyDark)
        , Background.color (rgb 0.95 0.95 0.95)
        ]
        [ el [ alignLeft ] (text "elm-ionicons")
        , row [ alignRight, spacing 5 ]
            [ viewHeaderIcon
                { url = "https://ionicons.com/"
                , label = "Ionicons website"
                , icon = Ionicon.ionic
                }
            , viewHeaderIcon
                { url = "https://package.elm-lang.org/packages/j-panasiuk/elm-ionicons/latest"
                , label = "elm-ionicons on Elm Package site"
                , icon = Ionicon.codeDownload
                }
            , viewHeaderIcon
                { url = "https://github.com/j-panasiuk/elm-ionicons"
                , label = "elm-ionicons on GitHub"
                , icon = Social.github
                }
            ]
        ]


viewHeaderIcon : { url : String, label : String, icon : Icon msg } -> Element msg
viewHeaderIcon { url, label, icon } =
    link []
        { url = url
        , label = el [ centerX, centerY ] <| html <| icon 32 greyDark
        }


viewControls : Model -> Element Msg
viewControls model =
    row
        [ width fill
        , padding 15
        , Background.color (rgb 0.95 0.95 0.95)
        , Border.solid
        , Border.width 1
        , Border.color (rgb 0.85 0.85 0.85)
        ]
        [ Input.search
            [ width fill
            , Border.solid
            , Border.width 1
            , Border.color (rgb 0.85 0.85 0.85)
            , Border.rounded 0
            , Input.focusedOnLoad
            ]
            { onChange = Search
            , text = model.searchPhrase
            , placeholder = Just (Input.placeholder [] (text "Search"))
            , label = Input.labelAbove [] none
            }
        ]


viewIconGroup : String -> List ( Tag, Icon msg ) -> Model -> Element msg
viewIconGroup groupTitle taggedIcons { searchPhrase } =
    Keyed.column
        [ width fill
        , alignLeft
        , alignTop
        , padding 15
        , spacing 4
        ]
        (( "title" ++ groupTitle, viewIconGroupTitle groupTitle )
            :: (taggedIcons
                    |> List.filter (\( tag, _ ) -> String.contains searchPhrase tag)
                    |> List.map
                        (\( tag, icon ) ->
                            ( "icon" ++ groupTitle ++ tag
                            , viewTitledIcon tag icon
                            )
                        )
               )
        )


viewIconGroupTitle : String -> Element msg
viewIconGroupTitle title =
    el
        [ paddingXY 0 8
        , Font.bold
        , Font.color (rgb01 greyMedium)
        ]
        (text title)


viewTitledIcon : String -> Icon msg -> Element msg
viewTitledIcon tag icon =
    row
        [ spacing 8
        , Font.size 18
        , Font.color (rgb01 greyMedium)
        ]
        [ viewIcon icon
        , text tag
        ]


viewIcon : Icon msg -> Element msg
viewIcon icon =
    el [ centerX, centerY ] <| html <| icon 40 greyDark



-- STYLES


rgb01 : RGBA -> Color
rgb01 { red, green, blue } =
    rgb
        (clamp 0 1 red)
        (clamp 0 1 green)
        (clamp 0 1 blue)


greyDark : RGBA
greyDark =
    RGBA 0.32 0.32 0.32 1


greyMedium : RGBA
greyMedium =
    RGBA 0.56 0.56 0.56 1



-- ICONS


type alias RGBA =
    { red : Float
    , green : Float
    , blue : Float
    , alpha : Float
    }


type alias Tag =
    String


type alias Icon msg =
    Int -> RGBA -> Html msg


ionicons : List ( Tag, Icon msg )
ionicons =
    [ pair "alertCircled" Ionicon.alertCircled
    , pair "alert" Ionicon.alert
    , pair "aperture" Ionicon.aperture
    , pair "archive" Ionicon.archive
    , pair "arrowDownA" Ionicon.arrowDownA
    , pair "arrowDownB" Ionicon.arrowDownB
    , pair "arrowDownC" Ionicon.arrowDownC
    , pair "arrowExpand" Ionicon.arrowExpand
    , pair "arrowGraphDownLeft" Ionicon.arrowGraphDownLeft
    , pair "arrowGraphDownRight" Ionicon.arrowGraphDownRight
    , pair "arrowGraphUpLeft" Ionicon.arrowGraphUpLeft
    , pair "arrowGraphUpRight" Ionicon.arrowGraphUpRight
    , pair "arrowLeftA" Ionicon.arrowLeftA
    , pair "arrowLeftB" Ionicon.arrowLeftB
    , pair "arrowLeftC" Ionicon.arrowLeftC
    , pair "arrowMove" Ionicon.arrowMove
    , pair "arrowResize" Ionicon.arrowResize
    , pair "arrowReturnLeft" Ionicon.arrowReturnLeft
    , pair "arrowReturnRight" Ionicon.arrowReturnRight
    , pair "arrowRightA" Ionicon.arrowRightA
    , pair "arrowRightB" Ionicon.arrowRightB
    , pair "arrowRightC" Ionicon.arrowRightC
    , pair "arrowShrink" Ionicon.arrowShrink
    , pair "arrowSwap" Ionicon.arrowSwap
    , pair "arrowUpA" Ionicon.arrowUpA
    , pair "arrowUpB" Ionicon.arrowUpB
    , pair "arrowUpC" Ionicon.arrowUpC
    , pair "asterisk" Ionicon.asterisk
    , pair "at" Ionicon.at
    , pair "backspaceOutline" Ionicon.backspaceOutline
    , pair "backspace" Ionicon.backspace
    , pair "bag" Ionicon.bag
    , pair "batteryCharging" Ionicon.batteryCharging
    , pair "batteryEmpty" Ionicon.batteryEmpty
    , pair "batteryFull" Ionicon.batteryFull
    , pair "batteryHalf" Ionicon.batteryHalf
    , pair "batteryLow" Ionicon.batteryLow
    , pair "beaker" Ionicon.beaker
    , pair "beer" Ionicon.beer
    , pair "bluetooth" Ionicon.bluetooth
    , pair "bonfire" Ionicon.bonfire
    , pair "bookmark" Ionicon.bookmark
    , pair "bowtie" Ionicon.bowtie
    , pair "briefcase" Ionicon.briefcase
    , pair "bug" Ionicon.bug
    , pair "calculator" Ionicon.calculator
    , pair "calendar" Ionicon.calendar
    , pair "camera" Ionicon.camera
    , pair "card" Ionicon.card
    , pair "cash" Ionicon.cash
    , pair "chatboxWorking" Ionicon.chatboxWorking
    , pair "chatbox" Ionicon.chatbox
    , pair "chatboxes" Ionicon.chatboxes
    , pair "chatbubbleWorking" Ionicon.chatbubbleWorking
    , pair "chatbubble" Ionicon.chatbubble
    , pair "chatbubbles" Ionicon.chatbubbles
    , pair "checkmarkCircled" Ionicon.checkmarkCircled
    , pair "checkmarkRound" Ionicon.checkmarkRound
    , pair "checkmark" Ionicon.checkmark
    , pair "chevronDown" Ionicon.chevronDown
    , pair "chevronLeft" Ionicon.chevronLeft
    , pair "chevronRight" Ionicon.chevronRight
    , pair "chevronUp" Ionicon.chevronUp
    , pair "clipboard" Ionicon.clipboard
    , pair "clock" Ionicon.clock
    , pair "closeCircled" Ionicon.closeCircled
    , pair "closeRound" Ionicon.closeRound
    , pair "close" Ionicon.close
    , pair "closedCaptioning" Ionicon.closedCaptioning
    , pair "cloud" Ionicon.cloud
    , pair "codeDownload" Ionicon.codeDownload
    , pair "codeWorking" Ionicon.codeWorking
    , pair "code" Ionicon.code
    , pair "coffee" Ionicon.coffee
    , pair "compass" Ionicon.compass
    , pair "compose" Ionicon.compose
    , pair "connectionBars" Ionicon.connectionBars
    , pair "contrast" Ionicon.contrast
    , pair "crop" Ionicon.crop
    , pair "cube" Ionicon.cube
    , pair "disc" Ionicon.disc
    , pair "documentText" Ionicon.documentText
    , pair "document" Ionicon.document
    , pair "drag" Ionicon.drag
    , pair "earth" Ionicon.earth
    , pair "easel" Ionicon.easel
    , pair "edit" Ionicon.edit
    , pair "egg" Ionicon.egg
    , pair "eject" Ionicon.eject
    , pair "emailUnread" Ionicon.emailUnread
    , pair "email" Ionicon.email
    , pair "erlenmeyerFlaskBubbles" Ionicon.erlenmeyerFlaskBubbles
    , pair "erlenmeyerFlask" Ionicon.erlenmeyerFlask
    , pair "eyeDisabled" Ionicon.eyeDisabled
    , pair "eye" Ionicon.eye
    , pair "female" Ionicon.female
    , pair "filing" Ionicon.filing
    , pair "filmMarker" Ionicon.filmMarker
    , pair "fireball" Ionicon.fireball
    , pair "flag" Ionicon.flag
    , pair "flame" Ionicon.flame
    , pair "flashOff" Ionicon.flashOff
    , pair "flash" Ionicon.flash
    , pair "folder" Ionicon.folder
    , pair "forkRepo" Ionicon.forkRepo
    , pair "fork" Ionicon.fork
    , pair "forward" Ionicon.forward
    , pair "funnel" Ionicon.funnel
    , pair "gearA" Ionicon.gearA
    , pair "gearB" Ionicon.gearB
    , pair "grid" Ionicon.grid
    , pair "hammer" Ionicon.hammer
    , pair "happyOutline" Ionicon.happyOutline
    , pair "happy" Ionicon.happy
    , pair "headphone" Ionicon.headphone
    , pair "heartBroken" Ionicon.heartBroken
    , pair "heart" Ionicon.heart
    , pair "helpBuoy" Ionicon.helpBuoy
    , pair "helpCircled" Ionicon.helpCircled
    , pair "help" Ionicon.help
    , pair "home" Ionicon.home
    , pair "icecream" Ionicon.icecream
    , pair "image" Ionicon.image
    , pair "images" Ionicon.images
    , pair "informationCircled" Ionicon.informationCircled
    , pair "information" Ionicon.information
    , pair "ionic" Ionicon.ionic
    , pair "ipad" Ionicon.ipad
    , pair "iphone" Ionicon.iphone
    , pair "ipod" Ionicon.ipod
    , pair "jet" Ionicon.jet
    , pair "key" Ionicon.key
    , pair "knife" Ionicon.knife
    , pair "laptop" Ionicon.laptop
    , pair "leaf" Ionicon.leaf
    , pair "levels" Ionicon.levels
    , pair "lightbulb" Ionicon.lightbulb
    , pair "link" Ionicon.link
    , pair "loadA" Ionicon.loadA
    , pair "loadB" Ionicon.loadB
    , pair "loadC" Ionicon.loadC
    , pair "loadD" Ionicon.loadD
    , pair "location" Ionicon.location
    , pair "lockCombination" Ionicon.lockCombination
    , pair "locked" Ionicon.locked
    , pair "logIn" Ionicon.logIn
    , pair "logOut" Ionicon.logOut
    , pair "loop" Ionicon.loop
    , pair "magnet" Ionicon.magnet
    , pair "male" Ionicon.male
    , pair "man" Ionicon.man
    , pair "map" Ionicon.map
    , pair "medkit" Ionicon.medkit
    , pair "merge" Ionicon.merge
    , pair "micA" Ionicon.micA
    , pair "micB" Ionicon.micB
    , pair "micC" Ionicon.micC
    , pair "minusCircled" Ionicon.minusCircled
    , pair "minusRound" Ionicon.minusRound
    , pair "minus" Ionicon.minus
    , pair "modelS" Ionicon.modelS
    , pair "monitor" Ionicon.monitor
    , pair "more" Ionicon.more
    , pair "mouse" Ionicon.mouse
    , pair "musicNote" Ionicon.musicNote
    , pair "naviconRound" Ionicon.naviconRound
    , pair "navicon" Ionicon.navicon
    , pair "navigate" Ionicon.navigate
    , pair "network" Ionicon.network
    , pair "noSmoking" Ionicon.noSmoking
    , pair "nuclear" Ionicon.nuclear
    , pair "outlet" Ionicon.outlet
    , pair "paintbrush" Ionicon.paintbrush
    , pair "paintbucket" Ionicon.paintbucket
    , pair "paperAirplane" Ionicon.paperAirplane
    , pair "paperclip" Ionicon.paperclip
    , pair "pause" Ionicon.pause
    , pair "personAdd" Ionicon.personAdd
    , pair "personStalker" Ionicon.personStalker
    , pair "person" Ionicon.person
    , pair "pieGraph" Ionicon.pieGraph
    , pair "pin" Ionicon.pin
    , pair "pinpoint" Ionicon.pinpoint
    , pair "pizza" Ionicon.pizza
    , pair "plane" Ionicon.plane
    , pair "planet" Ionicon.planet
    , pair "play" Ionicon.play
    , pair "playstation" Ionicon.playstation
    , pair "plusCircled" Ionicon.plusCircled
    , pair "plusRound" Ionicon.plusRound
    , pair "plus" Ionicon.plus
    , pair "podium" Ionicon.podium
    , pair "pound" Ionicon.pound
    , pair "power" Ionicon.power
    , pair "pricetag" Ionicon.pricetag
    , pair "pricetags" Ionicon.pricetags
    , pair "printer" Ionicon.printer
    , pair "pullRequest" Ionicon.pullRequest
    , pair "qrScanner" Ionicon.qrScanner
    , pair "quote" Ionicon.quote
    , pair "radioWaves" Ionicon.radioWaves
    , pair "record" Ionicon.record
    , pair "refresh" Ionicon.refresh
    , pair "replyAll" Ionicon.replyAll
    , pair "reply" Ionicon.reply
    , pair "ribbonA" Ionicon.ribbonA
    , pair "ribbonB" Ionicon.ribbonB
    , pair "sadOutline" Ionicon.sadOutline
    , pair "sad" Ionicon.sad
    , pair "scissors" Ionicon.scissors
    , pair "search" Ionicon.search
    , pair "settings" Ionicon.settings
    , pair "share" Ionicon.share
    , pair "shuffle" Ionicon.shuffle
    , pair "skipBackward" Ionicon.skipBackward
    , pair "skipForward" Ionicon.skipForward
    , pair "soupCanOutline" Ionicon.soupCanOutline
    , pair "soupCan" Ionicon.soupCan
    , pair "speakerphone" Ionicon.speakerphone
    , pair "speedometer" Ionicon.speedometer
    , pair "spoon" Ionicon.spoon
    , pair "star" Ionicon.star
    , pair "starBars" Ionicon.starBars
    , pair "steam" Ionicon.steam
    , pair "stop" Ionicon.stop
    , pair "thermometer" Ionicon.thermometer
    , pair "thumbsdown" Ionicon.thumbsdown
    , pair "thumbsup" Ionicon.thumbsup
    , pair "toggleFilled" Ionicon.toggleFilled
    , pair "toggle" Ionicon.toggle
    , pair "transgender" Ionicon.transgender
    , pair "trashA" Ionicon.trashA
    , pair "trashB" Ionicon.trashB
    , pair "trophy" Ionicon.trophy
    , pair "tshirtOutline" Ionicon.tshirtOutline
    , pair "tshirt" Ionicon.tshirt
    , pair "umbrella" Ionicon.umbrella
    , pair "university" Ionicon.university
    , pair "unlocked" Ionicon.unlocked
    , pair "upload" Ionicon.upload
    , pair "usb" Ionicon.usb
    , pair "videocamera" Ionicon.videocamera
    , pair "volumeHigh" Ionicon.volumeHigh
    , pair "volumeLow" Ionicon.volumeLow
    , pair "volumeMedium" Ionicon.volumeMedium
    , pair "volumeMute" Ionicon.volumeMute
    , pair "wand" Ionicon.wand
    , pair "waterdrop" Ionicon.waterdrop
    , pair "wifi" Ionicon.wifi
    , pair "wineglass" Ionicon.wineglass
    , pair "woman" Ionicon.woman
    , pair "wrench" Ionicon.wrench
    , pair "xbox" Ionicon.xbox
    ]


androidIcons : List ( Tag, Icon msg )
androidIcons =
    [ pair "addCircle" Android.addCircle
    , pair "add" Android.add
    , pair "alarmClock" Android.alarmClock
    , pair "alert" Android.alert
    , pair "apps" Android.apps
    , pair "archive" Android.archive
    , pair "arrowBack" Android.arrowBack
    , pair "arrowDown" Android.arrowDown
    , pair "arrowDropdownCircle" Android.arrowDropdownCircle
    , pair "arrowDropdown" Android.arrowDropdown
    , pair "arrowDropleftCircle" Android.arrowDropleftCircle
    , pair "arrowDropleft" Android.arrowDropleft
    , pair "arrowDroprightCircle" Android.arrowDroprightCircle
    , pair "arrowDropright" Android.arrowDropright
    , pair "arrowDropupCircle" Android.arrowDropupCircle
    , pair "arrowDropup" Android.arrowDropup
    , pair "arrowForward" Android.arrowForward
    , pair "arrowUp" Android.arrowUp
    , pair "attach" Android.attach
    , pair "bar" Android.bar
    , pair "bicycle" Android.bicycle
    , pair "boat" Android.boat
    , pair "bookmark" Android.bookmark
    , pair "bulb" Android.bulb
    , pair "bus" Android.bus
    , pair "calendar" Android.calendar
    , pair "call" Android.call
    , pair "camera" Android.camera
    , pair "cancel" Android.cancel
    , pair "car" Android.car
    , pair "cart" Android.cart
    , pair "chat" Android.chat
    , pair "checkboxBlank" Android.checkboxBlank
    , pair "checkboxOutlineBlank" Android.checkboxOutlineBlank
    , pair "checkboxOutline" Android.checkboxOutline
    , pair "checkbox" Android.checkbox
    , pair "checkmarkCircle" Android.checkmarkCircle
    , pair "clipboard" Android.clipboard
    , pair "close" Android.close
    , pair "cloudCircle" Android.cloudCircle
    , pair "cloudDone" Android.cloudDone
    , pair "cloudOutline" Android.cloudOutline
    , pair "cloud" Android.cloud
    , pair "colorPalette" Android.colorPalette
    , pair "compass" Android.compass
    , pair "contact" Android.contact
    , pair "contacts" Android.contacts
    , pair "contract" Android.contract
    , pair "create" Android.create
    , pair "delete" Android.delete
    , pair "desktop" Android.desktop
    , pair "document" Android.document
    , pair "doneAll" Android.doneAll
    , pair "done" Android.done
    , pair "download" Android.download
    , pair "drafts" Android.drafts
    , pair "exit" Android.exit
    , pair "expand" Android.expand
    , pair "favoriteOutline" Android.favoriteOutline
    , pair "favorite" Android.favorite
    , pair "film" Android.film
    , pair "folderOpen" Android.folderOpen
    , pair "folder" Android.folder
    , pair "funnel" Android.funnel
    , pair "globe" Android.globe
    , pair "hand" Android.hand
    , pair "hangout" Android.hangout
    , pair "happy" Android.happy
    , pair "home" Android.home
    , pair "image" Android.image
    , pair "laptop" Android.laptop
    , pair "list" Android.list
    , pair "locate" Android.locate
    , pair "lock" Android.lock
    , pair "mail" Android.mail
    , pair "map" Android.map
    , pair "menu" Android.menu
    , pair "microphoneOff" Android.microphoneOff
    , pair "microphone" Android.microphone
    , pair "moreHorizontal" Android.moreHorizontal
    , pair "moreVertical" Android.moreVertical
    , pair "navigate" Android.navigate
    , pair "notificationsNone" Android.notificationsNone
    , pair "notificationsOff" Android.notificationsOff
    , pair "notifications" Android.notifications
    , pair "open" Android.open
    , pair "options" Android.options
    , pair "people" Android.people
    , pair "personAdd" Android.personAdd
    , pair "person" Android.person
    , pair "phoneLandscape" Android.phoneLandscape
    , pair "phonePortrait" Android.phonePortrait
    , pair "pin" Android.pin
    , pair "plane" Android.plane
    , pair "playstore" Android.playstore
    , pair "print" Android.print
    , pair "radioButtonOff" Android.radioButtonOff
    , pair "radioButtonOn" Android.radioButtonOn
    , pair "refresh" Android.refresh
    , pair "removeCircle" Android.removeCircle
    , pair "remove" Android.remove
    , pair "restaurant" Android.restaurant
    , pair "sad" Android.sad
    , pair "search" Android.search
    , pair "send" Android.send
    , pair "settings" Android.settings
    , pair "shareAlt" Android.shareAlt
    , pair "share" Android.share
    , pair "starHalf" Android.starHalf
    , pair "starOutline" Android.starOutline
    , pair "star" Android.star
    , pair "stopwatch" Android.stopwatch
    , pair "subway" Android.subway
    , pair "sunny" Android.sunny
    , pair "sync" Android.sync
    , pair "textsms" Android.textsms
    , pair "time" Android.time
    , pair "train" Android.train
    , pair "unlock" Android.unlock
    , pair "upload" Android.upload
    , pair "volumeDown" Android.volumeDown
    , pair "volumeMute" Android.volumeMute
    , pair "volumeOff" Android.volumeOff
    , pair "volumeUp" Android.volumeUp
    , pair "walk" Android.walk
    , pair "warning" Android.warning
    , pair "watch" Android.watch
    , pair "wifi" Android.wifi
    ]


iosIcons : List ( Tag, Icon msg )
iosIcons =
    [ pair "alarmOutline" Ios.alarmOutline
    , pair "alarm" Ios.alarm
    , pair "albumsOutline" Ios.albumsOutline
    , pair "albums" Ios.albums
    , pair "americanfootballOutline" Ios.americanfootballOutline
    , pair "americanfootball" Ios.americanfootball
    , pair "analyticsOutline" Ios.analyticsOutline
    , pair "analytics" Ios.analytics
    , pair "arrowBack" Ios.arrowBack
    , pair "arrowDown" Ios.arrowDown
    , pair "arrowForward" Ios.arrowForward
    , pair "arrowLeft" Ios.arrowLeft
    , pair "arrowRight" Ios.arrowRight
    , pair "arrowThinDown" Ios.arrowThinDown
    , pair "arrowThinLeft" Ios.arrowThinLeft
    , pair "arrowThinRight" Ios.arrowThinRight
    , pair "arrowThinUp" Ios.arrowThinUp
    , pair "arrowUp" Ios.arrowUp
    , pair "atOutline" Ios.atOutline
    , pair "at" Ios.at
    , pair "barcodeOutline" Ios.barcodeOutline
    , pair "barcode" Ios.barcode
    , pair "baseballOutline" Ios.baseballOutline
    , pair "baseball" Ios.baseball
    , pair "basketballOutline" Ios.basketballOutline
    , pair "basketball" Ios.basketball
    , pair "bellOutline" Ios.bellOutline
    , pair "bell" Ios.bell
    , pair "bodyOutline" Ios.bodyOutline
    , pair "body" Ios.body
    , pair "boltOutline" Ios.boltOutline
    , pair "bolt" Ios.bolt
    , pair "bookOutline" Ios.bookOutline
    , pair "book" Ios.book
    , pair "bookmarksOutline" Ios.bookmarksOutline
    , pair "bookmarks" Ios.bookmarks
    , pair "boxOutline" Ios.boxOutline
    , pair "box" Ios.box
    , pair "briefcaseOutline" Ios.briefcaseOutline
    , pair "briefcase" Ios.briefcase
    , pair "browsersOutline" Ios.browsersOutline
    , pair "browsers" Ios.browsers
    , pair "calculatorOutline" Ios.calculatorOutline
    , pair "calculator" Ios.calculator
    , pair "calendarOutline" Ios.calendarOutline
    , pair "calendar" Ios.calendar
    , pair "cameraOutline" Ios.cameraOutline
    , pair "camera" Ios.camera
    , pair "cartOutline" Ios.cartOutline
    , pair "cart" Ios.cart
    , pair "chatboxesOutline" Ios.chatboxesOutline
    , pair "chatboxes" Ios.chatboxes
    , pair "chatbubbleOutline" Ios.chatbubbleOutline
    , pair "chatbubble" Ios.chatbubble
    , pair "checkmarkEmpty" Ios.checkmarkEmpty
    , pair "checkmarkOutline" Ios.checkmarkOutline
    , pair "checkmark" Ios.checkmark
    , pair "circleFilled" Ios.circleFilled
    , pair "circleOutline" Ios.circleOutline
    , pair "clockOutline" Ios.clockOutline
    , pair "clock" Ios.clock
    , pair "closeEmpty" Ios.closeEmpty
    , pair "closeOutline" Ios.closeOutline
    , pair "close" Ios.close
    , pair "cloudDownloadOutline" Ios.cloudDownloadOutline
    , pair "cloudDownload" Ios.cloudDownload
    , pair "cloudOutline" Ios.cloudOutline
    , pair "cloudUploadOutline" Ios.cloudUploadOutline
    , pair "cloudUpload" Ios.cloudUpload
    , pair "cloud" Ios.cloud
    , pair "cloudyNightOutline" Ios.cloudyNightOutline
    , pair "cloudyNight" Ios.cloudyNight
    , pair "cloudyOutline" Ios.cloudyOutline
    , pair "cloudy" Ios.cloudy
    , pair "cogOutline" Ios.cogOutline
    , pair "cog" Ios.cog
    , pair "colorFilterOutline" Ios.colorFilterOutline
    , pair "colorFilter" Ios.colorFilter
    , pair "colorWandOutline" Ios.colorWandOutline
    , pair "colorWand" Ios.colorWand
    , pair "composeOutline" Ios.composeOutline
    , pair "compose" Ios.compose
    , pair "contactOutline" Ios.contactOutline
    , pair "contact" Ios.contact
    , pair "copyOutline" Ios.copyOutline
    , pair "copy" Ios.copy
    , pair "cropStrong" Ios.cropStrong
    , pair "crop" Ios.crop
    , pair "downloadOutline" Ios.downloadOutline
    , pair "download" Ios.download
    , pair "drag" Ios.drag
    , pair "emailOutline" Ios.emailOutline
    , pair "email" Ios.email
    , pair "eyeOutline" Ios.eyeOutline
    , pair "eye" Ios.eye
    , pair "fastforwardOutline" Ios.fastforwardOutline
    , pair "fastforward" Ios.fastforward
    , pair "filingOutline" Ios.filingOutline
    , pair "filing" Ios.filing
    , pair "filmOutline" Ios.filmOutline
    , pair "film" Ios.film
    , pair "flagOutline" Ios.flagOutline
    , pair "flag" Ios.flag
    , pair "flameOutline" Ios.flameOutline
    , pair "flame" Ios.flame
    , pair "flaskOutline" Ios.flaskOutline
    , pair "flask" Ios.flask
    , pair "flowerOutline" Ios.flowerOutline
    , pair "flower" Ios.flower
    , pair "folderOutline" Ios.folderOutline
    , pair "folder" Ios.folder
    , pair "footballOutline" Ios.footballOutline
    , pair "football" Ios.football
    , pair "gameControllerAOutline" Ios.gameControllerAOutline
    , pair "gameControllerA" Ios.gameControllerA
    , pair "gameControllerBOutline" Ios.gameControllerBOutline
    , pair "gameControllerB" Ios.gameControllerB
    , pair "gearOutline" Ios.gearOutline
    , pair "gear" Ios.gear
    , pair "glassesOutline" Ios.glassesOutline
    , pair "glasses" Ios.glasses
    , pair "gridViewOutline" Ios.gridViewOutline
    , pair "gridView" Ios.gridView
    , pair "heartOutline" Ios.heartOutline
    , pair "heart" Ios.heart
    , pair "helpEmpty" Ios.helpEmpty
    , pair "helpOutline" Ios.helpOutline
    , pair "help" Ios.help
    , pair "homeOutline" Ios.homeOutline
    , pair "home" Ios.home
    , pair "infiniteOutline" Ios.infiniteOutline
    , pair "infinite" Ios.infinite
    , pair "informationEmpty" Ios.informationEmpty
    , pair "informationOutline" Ios.informationOutline
    , pair "information" Ios.information
    , pair "ionicOutline" Ios.ionicOutline
    , pair "keypadOutline" Ios.keypadOutline
    , pair "keypad" Ios.keypad
    , pair "lightbulbOutline" Ios.lightbulbOutline
    , pair "lightbulb" Ios.lightbulb
    , pair "listOutline" Ios.listOutline
    , pair "list" Ios.list
    , pair "locationOutline" Ios.locationOutline
    , pair "location" Ios.location
    , pair "lockedOutline" Ios.lockedOutline
    , pair "locked" Ios.locked
    , pair "loopStrong" Ios.loopStrong
    , pair "loop" Ios.loop
    , pair "medicalOutline" Ios.medicalOutline
    , pair "medical" Ios.medical
    , pair "medkitOutline" Ios.medkitOutline
    , pair "medkit" Ios.medkit
    , pair "micOff" Ios.micOff
    , pair "micOutline" Ios.micOutline
    , pair "mic" Ios.mic
    , pair "minusEmpty" Ios.minusEmpty
    , pair "minusOutline" Ios.minusOutline
    , pair "minus" Ios.minus
    , pair "monitorOutline" Ios.monitorOutline
    , pair "monitor" Ios.monitor
    , pair "moonOutline" Ios.moonOutline
    , pair "moon" Ios.moon
    , pair "moreOutline" Ios.moreOutline
    , pair "more" Ios.more
    , pair "musicalNote" Ios.musicalNote
    , pair "musicalNotes" Ios.musicalNotes
    , pair "navigateOutline" Ios.navigateOutline
    , pair "navigate" Ios.navigate
    , pair "nutritionOutline" Ios.nutritionOutline
    , pair "nutrition" Ios.nutrition
    , pair "paperOutline" Ios.paperOutline
    , pair "paper" Ios.paper
    , pair "paperplaneOutline" Ios.paperplaneOutline
    , pair "paperplane" Ios.paperplane
    , pair "partlySunnyOutline" Ios.partlySunnyOutline
    , pair "partlySunny" Ios.partlySunny
    , pair "pauseOutline" Ios.pauseOutline
    , pair "pause" Ios.pause
    , pair "pawOutline" Ios.pawOutline
    , pair "paw" Ios.paw
    , pair "peopleOutline" Ios.peopleOutline
    , pair "people" Ios.people
    , pair "personOutline" Ios.personOutline
    , pair "person" Ios.person
    , pair "personaddOutline" Ios.personaddOutline
    , pair "personadd" Ios.personadd
    , pair "photosOutline" Ios.photosOutline
    , pair "photos" Ios.photos
    , pair "pieOutline" Ios.pieOutline
    , pair "pie" Ios.pie
    , pair "pintOutline" Ios.pintOutline
    , pair "pint" Ios.pint
    , pair "playOutline" Ios.playOutline
    , pair "play" Ios.play
    , pair "plusEmpty" Ios.plusEmpty
    , pair "plusOutline" Ios.plusOutline
    , pair "plus" Ios.plus
    , pair "pricetagOutline" Ios.pricetagOutline
    , pair "pricetag" Ios.pricetag
    , pair "pricetagsOutline" Ios.pricetagsOutline
    , pair "pricetags" Ios.pricetags
    , pair "printerOutline" Ios.printerOutline
    , pair "printer" Ios.printer
    , pair "pulseStrong" Ios.pulseStrong
    , pair "pulse" Ios.pulse
    , pair "rainyOutline" Ios.rainyOutline
    , pair "rainy" Ios.rainy
    , pair "recordingOutline" Ios.recordingOutline
    , pair "recording" Ios.recording
    , pair "redoOutline" Ios.redoOutline
    , pair "redo" Ios.redo
    , pair "refreshEmpty" Ios.refreshEmpty
    , pair "refreshOutline" Ios.refreshOutline
    , pair "refresh" Ios.refresh
    , pair "reload" Ios.reload
    , pair "reverseCameraOutline" Ios.reverseCameraOutline
    , pair "reverseCamera" Ios.reverseCamera
    , pair "rewindOutline" Ios.rewindOutline
    , pair "rewind" Ios.rewind
    , pair "roseOutline" Ios.roseOutline
    , pair "rose" Ios.rose
    , pair "searchStrong" Ios.searchStrong
    , pair "search" Ios.search
    , pair "settingsStrong" Ios.settingsStrong
    , pair "settings" Ios.settings
    , pair "shuffleStrong" Ios.shuffleStrong
    , pair "shuffle" Ios.shuffle
    , pair "skipbackwardOutline" Ios.skipbackwardOutline
    , pair "skipbackward" Ios.skipbackward
    , pair "skipforwardOutline" Ios.skipforwardOutline
    , pair "skipforward" Ios.skipforward
    , pair "snowy" Ios.snowy
    , pair "speedometerOutline" Ios.speedometerOutline
    , pair "speedometer" Ios.speedometer
    , pair "starHalf" Ios.starHalf
    , pair "starOutline" Ios.starOutline
    , pair "star" Ios.star
    , pair "stopwatchOutline" Ios.stopwatchOutline
    , pair "stopwatch" Ios.stopwatch
    , pair "sunnyOutline" Ios.sunnyOutline
    , pair "sunny" Ios.sunny
    , pair "telephoneOutline" Ios.telephoneOutline
    , pair "telephone" Ios.telephone
    , pair "tennisballOutline" Ios.tennisballOutline
    , pair "tennisball" Ios.tennisball
    , pair "thunderstormOutline" Ios.thunderstormOutline
    , pair "thunderstorm" Ios.thunderstorm
    , pair "timeOutline" Ios.timeOutline
    , pair "time" Ios.time
    , pair "timerOutline" Ios.timerOutline
    , pair "timer" Ios.timer
    , pair "toggleOutline" Ios.toggleOutline
    , pair "toggle" Ios.toggle
    , pair "trashOutline" Ios.trashOutline
    , pair "trash" Ios.trash
    , pair "undoOutline" Ios.undoOutline
    , pair "undo" Ios.undo
    , pair "unlockedOutline" Ios.unlockedOutline
    , pair "unlocked" Ios.unlocked
    , pair "uploadOutline" Ios.uploadOutline
    , pair "upload" Ios.upload
    , pair "videocamOutline" Ios.videocamOutline
    , pair "videocam" Ios.videocam
    , pair "volumeHigh" Ios.volumeHigh
    , pair "volumeLow" Ios.volumeLow
    , pair "wineglassOutline" Ios.wineglassOutline
    , pair "wineglass" Ios.wineglass
    , pair "worldOutline" Ios.worldOutline
    , pair "world" Ios.world
    ]


socialIcons : List ( Tag, Icon msg )
socialIcons =
    [ pair "androidOutline" Social.androidOutline
    , pair "android" Social.android
    , pair "angularOutline" Social.angularOutline
    , pair "angular" Social.angular
    , pair "appleOutline" Social.appleOutline
    , pair "apple" Social.apple
    , pair "bitcoinOutline" Social.bitcoinOutline
    , pair "bitcoin" Social.bitcoin
    , pair "bufferOutline" Social.bufferOutline
    , pair "buffer" Social.buffer
    , pair "chromeOutline" Social.chromeOutline
    , pair "chrome" Social.chrome
    , pair "codepenOutline" Social.codepenOutline
    , pair "codepen" Social.codepen
    , pair "css3Outline" Social.css3Outline
    , pair "css3" Social.css3
    , pair "designernewsOutline" Social.designernewsOutline
    , pair "designernews" Social.designernews
    , pair "dribbbleOutline" Social.dribbbleOutline
    , pair "dribbble" Social.dribbble
    , pair "dropboxOutline" Social.dropboxOutline
    , pair "dropbox" Social.dropbox
    , pair "euroOutline" Social.euroOutline
    , pair "euro" Social.euro
    , pair "facebookOutline" Social.facebookOutline
    , pair "facebook" Social.facebook
    , pair "foursquareOutline" Social.foursquareOutline
    , pair "foursquare" Social.foursquare
    , pair "freebsdDevil" Social.freebsdDevil
    , pair "githubOutline" Social.githubOutline
    , pair "github" Social.github
    , pair "googleOutline" Social.googleOutline
    , pair "google" Social.google
    , pair "googleplusOutline" Social.googleplusOutline
    , pair "googleplus" Social.googleplus
    , pair "hackernewsOutline" Social.hackernewsOutline
    , pair "hackernews" Social.hackernews
    , pair "html5Outline" Social.html5Outline
    , pair "html5" Social.html5
    , pair "instagramOutline" Social.instagramOutline
    , pair "instagram" Social.instagram
    , pair "javascriptOutline" Social.javascriptOutline
    , pair "javascript" Social.javascript
    , pair "linkedinOutline" Social.linkedinOutline
    , pair "linkedin" Social.linkedin
    , pair "markdown" Social.markdown
    , pair "nodejs" Social.nodejs
    , pair "octocat" Social.octocat
    , pair "pinterestOutline" Social.pinterestOutline
    , pair "pinterest" Social.pinterest
    , pair "python" Social.python
    , pair "redditOutline" Social.redditOutline
    , pair "reddit" Social.reddit
    , pair "rssOutline" Social.rssOutline
    , pair "rss" Social.rss
    , pair "sass" Social.sass
    , pair "skypeOutline" Social.skypeOutline
    , pair "skype" Social.skype
    , pair "snapchatOutline" Social.snapchatOutline
    , pair "snapchat" Social.snapchat
    , pair "tumblrOutline" Social.tumblrOutline
    , pair "tumblr" Social.tumblr
    , pair "tux" Social.tux
    , pair "twitchOutline" Social.twitchOutline
    , pair "twitch" Social.twitch
    , pair "twitterOutline" Social.twitterOutline
    , pair "twitter" Social.twitter
    , pair "usdOutline" Social.usdOutline
    , pair "usd" Social.usd
    , pair "vimeoOutline" Social.vimeoOutline
    , pair "vimeo" Social.vimeo
    , pair "whatsappOutline" Social.whatsappOutline
    , pair "whatsapp" Social.whatsapp
    , pair "windowsOutline" Social.windowsOutline
    , pair "windows" Social.windows
    , pair "wordpressOutline" Social.wordpressOutline
    , pair "wordpress" Social.wordpress
    , pair "yahooOutline" Social.yahooOutline
    , pair "yahoo" Social.yahoo
    , pair "yenOutline" Social.yenOutline
    , pair "yen" Social.yen
    , pair "youtubeOutline" Social.youtubeOutline
    , pair "youtube" Social.youtube
    ]
