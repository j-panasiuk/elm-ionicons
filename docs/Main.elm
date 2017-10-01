module Main exposing (main)

import Color exposing (Color)
import Element exposing (Element)
import Element.Attributes exposing (..)
import Element.Input as Input
import Html exposing (Html)
import Html.Attributes as A
import Ionicon
import Ionicon.Android as Android
import Ionicon.Ios as Ios
import Ionicon.Social as Social
import Style exposing (StyleSheet, style)
import Style.Color as Color
import Style.Font as Font


(=>) : a -> b -> ( a, b )
(=>) =
    (,)


type alias Model =
    { search : String
    , includeIonicon : Bool
    , includeAndroid : Bool
    , includeIos : Bool
    , includeSocial : Bool
    }


type alias Tag =
    String


type alias Icon msg =
    Int -> Color -> Html msg


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = initialModel
        , update = update
        , view = view
        }


initialModel : Model
initialModel =
    { search = ""
    , includeIonicon = True
    , includeAndroid = True
    , includeIos = True
    , includeSocial = True
    }


type Msg
    = SearchIcons String
    | IncludeIonicon Bool
    | IncludeAndroid Bool
    | IncludeIos Bool
    | IncludeSocial Bool


update : Msg -> Model -> Model
update msg model =
    case msg of
        SearchIcons search ->
            { model | search = search }

        IncludeIonicon flag ->
            { model | includeIonicon = flag }

        IncludeAndroid flag ->
            { model | includeAndroid = flag }

        IncludeIos flag ->
            { model | includeIos = flag }

        IncludeSocial flag ->
            { model | includeSocial = flag }


hasTag : String -> ( Tag, Icon msg ) -> Bool
hasTag search ( tag, _ ) =
    String.contains (String.toLower search) (String.toLower tag)


view : Model -> Html Msg
view model =
    Element.viewport stylesheet <|
        Element.column Body
            [ paddingXY 30 20
            , spacing 20
            , minHeight fill
            ]
            [ Element.row Header
                [ width fill, height (px 40), center ]
                [ Element.text "elm-ionicons" ]
            , Element.row None
                [ width fill, verticalCenter, spread ]
                [ Input.text SearchBox
                    [ height (px 36), width fill, minWidth (px 240), verticalCenter ]
                    { onChange = SearchIcons
                    , value = model.search
                    , label = Input.labelLeft (Element.html <| Android.search 40 Color.white)
                    , options = []
                    }
                , Element.row None
                    [ spacing 10 ]
                    [ Input.styledCheckbox None
                        []
                        { onChange = IncludeIonicon
                        , label = Element.text "Ionicon"
                        , checked = model.includeIonicon
                        , options = []
                        , icon =
                            \flag ->
                                if flag then
                                    viewIonicon ( "Ionicon", Android.checkbox )
                                else
                                    viewIonicon ( "Ionicon", Android.checkboxBlank )
                        }
                    , Input.styledCheckbox None
                        []
                        { onChange = IncludeAndroid
                        , label = Element.text "Android"
                        , checked = model.includeAndroid
                        , options = []
                        , icon =
                            \flag ->
                                if flag then
                                    viewAndroidIcon ( "Android", Android.checkbox )
                                else
                                    viewAndroidIcon ( "Android", Android.checkboxBlank )
                        }
                    , Input.styledCheckbox None
                        []
                        { onChange = IncludeIos
                        , label = Element.text "iOS"
                        , checked = model.includeIos
                        , options = []
                        , icon =
                            \flag ->
                                if flag then
                                    viewIOSIcon ( "iOS", Android.checkbox )
                                else
                                    viewIOSIcon ( "iOS", Android.checkboxBlank )
                        }
                    , Input.styledCheckbox None
                        []
                        { onChange = IncludeSocial
                        , label = Element.text "Social"
                        , checked = model.includeSocial
                        , options = []
                        , icon =
                            \flag ->
                                if flag then
                                    viewSocialIcon ( "Social", Android.checkbox )
                                else
                                    viewSocialIcon ( "Social", Android.checkboxBlank )
                        }
                    ]
                ]
            , Element.when model.includeIonicon <|
                Element.wrappedRow None [] (List.map viewIonicon <| List.filter (hasTag model.search) ionicons)
            , Element.when model.includeAndroid <|
                Element.wrappedRow None [] (List.map viewAndroidIcon <| List.filter (hasTag model.search) androidIcons)
            , Element.when model.includeIos <|
                Element.wrappedRow None [] (List.map viewIOSIcon <| List.filter (hasTag model.search) iosIcons)
            , Element.when model.includeSocial <|
                Element.wrappedRow None [] (List.map viewSocialIcon <| List.filter (hasTag model.search) socialIcons)
            ]


viewIcon : Int -> Color -> ( Tag, Icon msg ) -> Element Styles variation msg
viewIcon size color ( tag, icon ) =
    Element.html <|
        Html.span [ A.title tag ] [ icon size color ]


viewIonicon : ( Tag, Icon msg ) -> Element Styles variation msg
viewIonicon =
    viewIcon 36 (Color.hsla 1 1 1 0.8)


viewAndroidIcon : ( Tag, Icon msg ) -> Element Styles variation msg
viewAndroidIcon =
    viewIcon 36 (Color.hsl 33.3 0.7 0.8)


viewIOSIcon : ( Tag, Icon msg ) -> Element Styles variation msg
viewIOSIcon =
    viewIcon 36 (Color.hsl 66.7 0.7 0.8)


viewSocialIcon : ( Tag, Icon msg ) -> Element Styles variation msg
viewSocialIcon =
    viewIcon 36 (Color.hsl 0 0.7 0.8)


type Styles
    = None
    | Body
    | Header
    | SearchBox


stylesheet : StyleSheet Styles variation
stylesheet =
    Style.styleSheet
        [ style Body
            [ Font.typeface [ Font.sansSerif ]
            , Color.background (Color.rgb 34 34 34)
            , Color.text (Color.hsla 1 1 1 0.8)
            ]
        , style Header
            [ Font.size 24
            ]
        , style SearchBox
            [ Color.background (Color.rgb 80 80 80)
            , Color.text Color.white
            , Font.size 16
            ]
        ]


ionicons : List ( Tag, Icon msg )
ionicons =
    [ "alertCircled" => Ionicon.alertCircled
    , "alert" => Ionicon.alert
    , "aperture" => Ionicon.aperture
    , "archive" => Ionicon.archive
    , "arrowDownA" => Ionicon.arrowDownA
    , "arrowDownB" => Ionicon.arrowDownB
    , "arrowDownC" => Ionicon.arrowDownC
    , "arrowExpand" => Ionicon.arrowExpand
    , "arrowGraphDownLeft" => Ionicon.arrowGraphDownLeft
    , "arrowGraphDownRight" => Ionicon.arrowGraphDownRight
    , "arrowGraphUpLeft" => Ionicon.arrowGraphUpLeft
    , "arrowGraphUpRight" => Ionicon.arrowGraphUpRight
    , "arrowLeftA" => Ionicon.arrowLeftA
    , "arrowLeftB" => Ionicon.arrowLeftB
    , "arrowLeftC" => Ionicon.arrowLeftC
    , "arrowMove" => Ionicon.arrowMove
    , "arrowResize" => Ionicon.arrowResize
    , "arrowReturnLeft" => Ionicon.arrowReturnLeft
    , "arrowReturnRight" => Ionicon.arrowReturnRight
    , "arrowRightA" => Ionicon.arrowRightA
    , "arrowRightB" => Ionicon.arrowRightB
    , "arrowRightC" => Ionicon.arrowRightC
    , "arrowShrink" => Ionicon.arrowShrink
    , "arrowSwap" => Ionicon.arrowSwap
    , "arrowUpA" => Ionicon.arrowUpA
    , "arrowUpB" => Ionicon.arrowUpB
    , "arrowUpC" => Ionicon.arrowUpC
    , "asterisk" => Ionicon.asterisk
    , "at" => Ionicon.at
    , "backspaceOutline" => Ionicon.backspaceOutline
    , "backspace" => Ionicon.backspace
    , "bag" => Ionicon.bag
    , "batteryCharging" => Ionicon.batteryCharging
    , "batteryEmpty" => Ionicon.batteryEmpty
    , "batteryFull" => Ionicon.batteryFull
    , "batteryHalf" => Ionicon.batteryHalf
    , "batteryLow" => Ionicon.batteryLow
    , "beaker" => Ionicon.beaker
    , "beer" => Ionicon.beer
    , "bluetooth" => Ionicon.bluetooth
    , "bonfire" => Ionicon.bonfire
    , "bookmark" => Ionicon.bookmark
    , "bowtie" => Ionicon.bowtie
    , "briefcase" => Ionicon.briefcase
    , "bug" => Ionicon.bug
    , "calculator" => Ionicon.calculator
    , "calendar" => Ionicon.calendar
    , "camera" => Ionicon.camera
    , "card" => Ionicon.card
    , "cash" => Ionicon.cash
    , "chatboxWorking" => Ionicon.chatboxWorking
    , "chatbox" => Ionicon.chatbox
    , "chatboxes" => Ionicon.chatboxes
    , "chatbubbleWorking" => Ionicon.chatbubbleWorking
    , "chatbubble" => Ionicon.chatbubble
    , "chatbubbles" => Ionicon.chatbubbles
    , "checkmarkCircled" => Ionicon.checkmarkCircled
    , "checkmarkRound" => Ionicon.checkmarkRound
    , "checkmark" => Ionicon.checkmark
    , "chevronDown" => Ionicon.chevronDown
    , "chevronLeft" => Ionicon.chevronLeft
    , "chevronRight" => Ionicon.chevronRight
    , "chevronUp" => Ionicon.chevronUp
    , "clipboard" => Ionicon.clipboard
    , "clock" => Ionicon.clock
    , "closeCircled" => Ionicon.closeCircled
    , "closeRound" => Ionicon.closeRound
    , "close" => Ionicon.close
    , "closedCaptioning" => Ionicon.closedCaptioning
    , "cloud" => Ionicon.cloud
    , "codeDownload" => Ionicon.codeDownload
    , "codeWorking" => Ionicon.codeWorking
    , "code" => Ionicon.code
    , "coffee" => Ionicon.coffee
    , "compass" => Ionicon.compass
    , "compose" => Ionicon.compose
    , "connectionBars" => Ionicon.connectionBars
    , "contrast" => Ionicon.contrast
    , "crop" => Ionicon.crop
    , "cube" => Ionicon.cube
    , "disc" => Ionicon.disc
    , "documentText" => Ionicon.documentText
    , "document" => Ionicon.document
    , "drag" => Ionicon.drag
    , "earth" => Ionicon.earth
    , "easel" => Ionicon.easel
    , "edit" => Ionicon.edit
    , "egg" => Ionicon.egg
    , "eject" => Ionicon.eject
    , "emailUnread" => Ionicon.emailUnread
    , "email" => Ionicon.email
    , "erlenmeyerFlaskBubbles" => Ionicon.erlenmeyerFlaskBubbles
    , "erlenmeyerFlask" => Ionicon.erlenmeyerFlask
    , "eyeDisabled" => Ionicon.eyeDisabled
    , "eye" => Ionicon.eye
    , "female" => Ionicon.female
    , "filing" => Ionicon.filing
    , "filmMarker" => Ionicon.filmMarker
    , "fireball" => Ionicon.fireball
    , "flag" => Ionicon.flag
    , "flame" => Ionicon.flame
    , "flashOff" => Ionicon.flashOff
    , "flash" => Ionicon.flash
    , "folder" => Ionicon.folder
    , "forkRepo" => Ionicon.forkRepo
    , "fork" => Ionicon.fork
    , "forward" => Ionicon.forward
    , "funnel" => Ionicon.funnel
    , "gearA" => Ionicon.gearA
    , "gearB" => Ionicon.gearB
    , "grid" => Ionicon.grid
    , "hammer" => Ionicon.hammer
    , "happyOutline" => Ionicon.happyOutline
    , "happy" => Ionicon.happy
    , "headphone" => Ionicon.headphone
    , "heartBroken" => Ionicon.heartBroken
    , "heart" => Ionicon.heart
    , "helpBuoy" => Ionicon.helpBuoy
    , "helpCircled" => Ionicon.helpCircled
    , "help" => Ionicon.help
    , "home" => Ionicon.home
    , "icecream" => Ionicon.icecream
    , "image" => Ionicon.image
    , "images" => Ionicon.images
    , "informationCircled" => Ionicon.informationCircled
    , "information" => Ionicon.information
    , "ionic" => Ionicon.ionic
    , "ipad" => Ionicon.ipad
    , "iphone" => Ionicon.iphone
    , "ipod" => Ionicon.ipod
    , "jet" => Ionicon.jet
    , "key" => Ionicon.key
    , "knife" => Ionicon.knife
    , "laptop" => Ionicon.laptop
    , "leaf" => Ionicon.leaf
    , "levels" => Ionicon.levels
    , "lightbulb" => Ionicon.lightbulb
    , "link" => Ionicon.link
    , "loadA" => Ionicon.loadA
    , "loadB" => Ionicon.loadB
    , "loadC" => Ionicon.loadC
    , "loadD" => Ionicon.loadD
    , "location" => Ionicon.location
    , "lockCombination" => Ionicon.lockCombination
    , "locked" => Ionicon.locked
    , "logIn" => Ionicon.logIn
    , "logOut" => Ionicon.logOut
    , "loop" => Ionicon.loop
    , "magnet" => Ionicon.magnet
    , "male" => Ionicon.male
    , "man" => Ionicon.man
    , "map" => Ionicon.map
    , "medkit" => Ionicon.medkit
    , "merge" => Ionicon.merge
    , "micA" => Ionicon.micA
    , "micB" => Ionicon.micB
    , "micC" => Ionicon.micC
    , "minusCircled" => Ionicon.minusCircled
    , "minusRound" => Ionicon.minusRound
    , "minus" => Ionicon.minus
    , "modelS" => Ionicon.modelS
    , "monitor" => Ionicon.monitor
    , "more" => Ionicon.more
    , "mouse" => Ionicon.mouse
    , "musicNote" => Ionicon.musicNote
    , "naviconRound" => Ionicon.naviconRound
    , "navicon" => Ionicon.navicon
    , "navigate" => Ionicon.navigate
    , "network" => Ionicon.network
    , "noSmoking" => Ionicon.noSmoking
    , "nuclear" => Ionicon.nuclear
    , "outlet" => Ionicon.outlet
    , "paintbrush" => Ionicon.paintbrush
    , "paintbucket" => Ionicon.paintbucket
    , "paperAirplane" => Ionicon.paperAirplane
    , "paperclip" => Ionicon.paperclip
    , "pause" => Ionicon.pause
    , "personAdd" => Ionicon.personAdd
    , "personStalker" => Ionicon.personStalker
    , "person" => Ionicon.person
    , "pieGraph" => Ionicon.pieGraph
    , "pin" => Ionicon.pin
    , "pinpoint" => Ionicon.pinpoint
    , "pizza" => Ionicon.pizza
    , "plane" => Ionicon.plane
    , "planet" => Ionicon.planet
    , "play" => Ionicon.play
    , "playstation" => Ionicon.playstation
    , "plusCircled" => Ionicon.plusCircled
    , "plusRound" => Ionicon.plusRound
    , "plus" => Ionicon.plus
    , "podium" => Ionicon.podium
    , "pound" => Ionicon.pound
    , "power" => Ionicon.power
    , "pricetag" => Ionicon.pricetag
    , "pricetags" => Ionicon.pricetags
    , "printer" => Ionicon.printer
    , "pullRequest" => Ionicon.pullRequest
    , "qrScanner" => Ionicon.qrScanner
    , "quote" => Ionicon.quote
    , "radioWaves" => Ionicon.radioWaves
    , "record" => Ionicon.record
    , "refresh" => Ionicon.refresh
    , "replyAll" => Ionicon.replyAll
    , "reply" => Ionicon.reply
    , "ribbonA" => Ionicon.ribbonA
    , "ribbonB" => Ionicon.ribbonB
    , "sadOutline" => Ionicon.sadOutline
    , "sad" => Ionicon.sad
    , "scissors" => Ionicon.scissors
    , "search" => Ionicon.search
    , "settings" => Ionicon.settings
    , "share" => Ionicon.share
    , "shuffle" => Ionicon.shuffle
    , "skipBackward" => Ionicon.skipBackward
    , "skipForward" => Ionicon.skipForward
    , "soupCanOutline" => Ionicon.soupCanOutline
    , "soupCan" => Ionicon.soupCan
    , "speakerphone" => Ionicon.speakerphone
    , "speedometer" => Ionicon.speedometer
    , "spoon" => Ionicon.spoon
    , "star" => Ionicon.star
    , "starBars" => Ionicon.starBars
    , "steam" => Ionicon.steam
    , "stop" => Ionicon.stop
    , "thermometer" => Ionicon.thermometer
    , "thumbsdown" => Ionicon.thumbsdown
    , "thumbsup" => Ionicon.thumbsup
    , "toggleFilled" => Ionicon.toggleFilled
    , "toggle" => Ionicon.toggle
    , "transgender" => Ionicon.transgender
    , "trashA" => Ionicon.trashA
    , "trashB" => Ionicon.trashB
    , "trophy" => Ionicon.trophy
    , "tshirtOutline" => Ionicon.tshirtOutline
    , "tshirt" => Ionicon.tshirt
    , "umbrella" => Ionicon.umbrella
    , "university" => Ionicon.university
    , "unlocked" => Ionicon.unlocked
    , "upload" => Ionicon.upload
    , "usb" => Ionicon.usb
    , "videocamera" => Ionicon.videocamera
    , "volumeHigh" => Ionicon.volumeHigh
    , "volumeLow" => Ionicon.volumeLow
    , "volumeMedium" => Ionicon.volumeMedium
    , "volumeMute" => Ionicon.volumeMute
    , "wand" => Ionicon.wand
    , "waterdrop" => Ionicon.waterdrop
    , "wifi" => Ionicon.wifi
    , "wineglass" => Ionicon.wineglass
    , "woman" => Ionicon.woman
    , "wrench" => Ionicon.wrench
    , "xbox" => Ionicon.xbox
    ]


androidIcons : List ( Tag, Icon msg )
androidIcons =
    [ "addCircle" => Android.addCircle
    , "add" => Android.add
    , "alarmClock" => Android.alarmClock
    , "alert" => Android.alert
    , "apps" => Android.apps
    , "archive" => Android.archive
    , "arrowBack" => Android.arrowBack
    , "arrowDown" => Android.arrowDown
    , "arrowDropdownCircle" => Android.arrowDropdownCircle
    , "arrowDropdown" => Android.arrowDropdown
    , "arrowDropleftCircle" => Android.arrowDropleftCircle
    , "arrowDropleft" => Android.arrowDropleft
    , "arrowDroprightCircle" => Android.arrowDroprightCircle
    , "arrowDropright" => Android.arrowDropright
    , "arrowDropupCircle" => Android.arrowDropupCircle
    , "arrowDropup" => Android.arrowDropup
    , "arrowForward" => Android.arrowForward
    , "arrowUp" => Android.arrowUp
    , "attach" => Android.attach
    , "bar" => Android.bar
    , "bicycle" => Android.bicycle
    , "boat" => Android.boat
    , "bookmark" => Android.bookmark
    , "bulb" => Android.bulb
    , "bus" => Android.bus
    , "calendar" => Android.calendar
    , "call" => Android.call
    , "camera" => Android.camera
    , "cancel" => Android.cancel
    , "car" => Android.car
    , "cart" => Android.cart
    , "chat" => Android.chat
    , "checkboxBlank" => Android.checkboxBlank
    , "checkboxOutlineBlank" => Android.checkboxOutlineBlank
    , "checkboxOutline" => Android.checkboxOutline
    , "checkbox" => Android.checkbox
    , "checkmarkCircle" => Android.checkmarkCircle
    , "clipboard" => Android.clipboard
    , "close" => Android.close
    , "cloudCircle" => Android.cloudCircle
    , "cloudDone" => Android.cloudDone
    , "cloudOutline" => Android.cloudOutline
    , "cloud" => Android.cloud
    , "colorPalette" => Android.colorPalette
    , "compass" => Android.compass
    , "contact" => Android.contact
    , "contacts" => Android.contacts
    , "contract" => Android.contract
    , "create" => Android.create
    , "delete" => Android.delete
    , "desktop" => Android.desktop
    , "document" => Android.document
    , "doneAll" => Android.doneAll
    , "done" => Android.done
    , "download" => Android.download
    , "drafts" => Android.drafts
    , "exit" => Android.exit
    , "expand" => Android.expand
    , "favoriteOutline" => Android.favoriteOutline
    , "favorite" => Android.favorite
    , "film" => Android.film
    , "folderOpen" => Android.folderOpen
    , "folder" => Android.folder
    , "funnel" => Android.funnel
    , "globe" => Android.globe
    , "hand" => Android.hand
    , "hangout" => Android.hangout
    , "happy" => Android.happy
    , "home" => Android.home
    , "image" => Android.image
    , "laptop" => Android.laptop
    , "list" => Android.list
    , "locate" => Android.locate
    , "lock" => Android.lock
    , "mail" => Android.mail
    , "map" => Android.map
    , "menu" => Android.menu
    , "microphoneOff" => Android.microphoneOff
    , "microphone" => Android.microphone
    , "moreHorizontal" => Android.moreHorizontal
    , "moreVertical" => Android.moreVertical
    , "navigate" => Android.navigate
    , "notificationsNone" => Android.notificationsNone
    , "notificationsOff" => Android.notificationsOff
    , "notifications" => Android.notifications
    , "open" => Android.open
    , "options" => Android.options
    , "people" => Android.people
    , "personAdd" => Android.personAdd
    , "person" => Android.person
    , "phoneLandscape" => Android.phoneLandscape
    , "phonePortrait" => Android.phonePortrait
    , "pin" => Android.pin
    , "plane" => Android.plane
    , "playstore" => Android.playstore
    , "print" => Android.print
    , "radioButtonOff" => Android.radioButtonOff
    , "radioButtonOn" => Android.radioButtonOn
    , "refresh" => Android.refresh
    , "removeCircle" => Android.removeCircle
    , "remove" => Android.remove
    , "restaurant" => Android.restaurant
    , "sad" => Android.sad
    , "search" => Android.search
    , "send" => Android.send
    , "settings" => Android.settings
    , "shareAlt" => Android.shareAlt
    , "share" => Android.share
    , "starHalf" => Android.starHalf
    , "starOutline" => Android.starOutline
    , "star" => Android.star
    , "stopwatch" => Android.stopwatch
    , "subway" => Android.subway
    , "sunny" => Android.sunny
    , "sync" => Android.sync
    , "textsms" => Android.textsms
    , "time" => Android.time
    , "train" => Android.train
    , "unlock" => Android.unlock
    , "upload" => Android.upload
    , "volumeDown" => Android.volumeDown
    , "volumeMute" => Android.volumeMute
    , "volumeOff" => Android.volumeOff
    , "volumeUp" => Android.volumeUp
    , "walk" => Android.walk
    , "warning" => Android.warning
    , "watch" => Android.watch
    , "wifi" => Android.wifi
    ]


iosIcons : List ( Tag, Icon msg )
iosIcons =
    [ "alarmOutline" => Ios.alarmOutline
    , "alarm" => Ios.alarm
    , "albumsOutline" => Ios.albumsOutline
    , "albums" => Ios.albums
    , "americanfootballOutline" => Ios.americanfootballOutline
    , "americanfootball" => Ios.americanfootball
    , "analyticsOutline" => Ios.analyticsOutline
    , "analytics" => Ios.analytics
    , "arrowBack" => Ios.arrowBack
    , "arrowDown" => Ios.arrowDown
    , "arrowForward" => Ios.arrowForward
    , "arrowLeft" => Ios.arrowLeft
    , "arrowRight" => Ios.arrowRight
    , "arrowThinDown" => Ios.arrowThinDown
    , "arrowThinLeft" => Ios.arrowThinLeft
    , "arrowThinRight" => Ios.arrowThinRight
    , "arrowThinUp" => Ios.arrowThinUp
    , "arrowUp" => Ios.arrowUp
    , "atOutline" => Ios.atOutline
    , "at" => Ios.at
    , "barcodeOutline" => Ios.barcodeOutline
    , "barcode" => Ios.barcode
    , "baseballOutline" => Ios.baseballOutline
    , "baseball" => Ios.baseball
    , "basketballOutline" => Ios.basketballOutline
    , "basketball" => Ios.basketball
    , "bellOutline" => Ios.bellOutline
    , "bell" => Ios.bell
    , "bodyOutline" => Ios.bodyOutline
    , "body" => Ios.body
    , "boltOutline" => Ios.boltOutline
    , "bolt" => Ios.bolt
    , "bookOutline" => Ios.bookOutline
    , "book" => Ios.book
    , "bookmarksOutline" => Ios.bookmarksOutline
    , "bookmarks" => Ios.bookmarks
    , "boxOutline" => Ios.boxOutline
    , "box" => Ios.box
    , "briefcaseOutline" => Ios.briefcaseOutline
    , "briefcase" => Ios.briefcase
    , "browsersOutline" => Ios.browsersOutline
    , "browsers" => Ios.browsers
    , "calculatorOutline" => Ios.calculatorOutline
    , "calculator" => Ios.calculator
    , "calendarOutline" => Ios.calendarOutline
    , "calendar" => Ios.calendar
    , "cameraOutline" => Ios.cameraOutline
    , "camera" => Ios.camera
    , "cartOutline" => Ios.cartOutline
    , "cart" => Ios.cart
    , "chatboxesOutline" => Ios.chatboxesOutline
    , "chatboxes" => Ios.chatboxes
    , "chatbubbleOutline" => Ios.chatbubbleOutline
    , "chatbubble" => Ios.chatbubble
    , "checkmarkEmpty" => Ios.checkmarkEmpty
    , "checkmarkOutline" => Ios.checkmarkOutline
    , "checkmark" => Ios.checkmark
    , "circleFilled" => Ios.circleFilled
    , "circleOutline" => Ios.circleOutline
    , "clockOutline" => Ios.clockOutline
    , "clock" => Ios.clock
    , "closeEmpty" => Ios.closeEmpty
    , "closeOutline" => Ios.closeOutline
    , "close" => Ios.close
    , "cloudDownloadOutline" => Ios.cloudDownloadOutline
    , "cloudDownload" => Ios.cloudDownload
    , "cloudOutline" => Ios.cloudOutline
    , "cloudUploadOutline" => Ios.cloudUploadOutline
    , "cloudUpload" => Ios.cloudUpload
    , "cloud" => Ios.cloud
    , "cloudyNightOutline" => Ios.cloudyNightOutline
    , "cloudyNight" => Ios.cloudyNight
    , "cloudyOutline" => Ios.cloudyOutline
    , "cloudy" => Ios.cloudy
    , "cogOutline" => Ios.cogOutline
    , "cog" => Ios.cog
    , "colorFilterOutline" => Ios.colorFilterOutline
    , "colorFilter" => Ios.colorFilter
    , "colorWandOutline" => Ios.colorWandOutline
    , "colorWand" => Ios.colorWand
    , "composeOutline" => Ios.composeOutline
    , "compose" => Ios.compose
    , "contactOutline" => Ios.contactOutline
    , "contact" => Ios.contact
    , "copyOutline" => Ios.copyOutline
    , "copy" => Ios.copy
    , "cropStrong" => Ios.cropStrong
    , "crop" => Ios.crop
    , "downloadOutline" => Ios.downloadOutline
    , "download" => Ios.download
    , "drag" => Ios.drag
    , "emailOutline" => Ios.emailOutline
    , "email" => Ios.email
    , "eyeOutline" => Ios.eyeOutline
    , "eye" => Ios.eye
    , "fastforwardOutline" => Ios.fastforwardOutline
    , "fastforward" => Ios.fastforward
    , "filingOutline" => Ios.filingOutline
    , "filing" => Ios.filing
    , "filmOutline" => Ios.filmOutline
    , "film" => Ios.film
    , "flagOutline" => Ios.flagOutline
    , "flag" => Ios.flag
    , "flameOutline" => Ios.flameOutline
    , "flame" => Ios.flame
    , "flaskOutline" => Ios.flaskOutline
    , "flask" => Ios.flask
    , "flowerOutline" => Ios.flowerOutline
    , "flower" => Ios.flower
    , "folderOutline" => Ios.folderOutline
    , "folder" => Ios.folder
    , "footballOutline" => Ios.footballOutline
    , "football" => Ios.football
    , "gameControllerAOutline" => Ios.gameControllerAOutline
    , "gameControllerA" => Ios.gameControllerA
    , "gameControllerBOutline" => Ios.gameControllerBOutline
    , "gameControllerB" => Ios.gameControllerB
    , "gearOutline" => Ios.gearOutline
    , "gear" => Ios.gear
    , "glassesOutline" => Ios.glassesOutline
    , "glasses" => Ios.glasses
    , "gridViewOutline" => Ios.gridViewOutline
    , "gridView" => Ios.gridView
    , "heartOutline" => Ios.heartOutline
    , "heart" => Ios.heart
    , "helpEmpty" => Ios.helpEmpty
    , "helpOutline" => Ios.helpOutline
    , "help" => Ios.help
    , "homeOutline" => Ios.homeOutline
    , "home" => Ios.home
    , "infiniteOutline" => Ios.infiniteOutline
    , "infinite" => Ios.infinite
    , "informationEmpty" => Ios.informationEmpty
    , "informationOutline" => Ios.informationOutline
    , "information" => Ios.information
    , "ionicOutline" => Ios.ionicOutline
    , "keypadOutline" => Ios.keypadOutline
    , "keypad" => Ios.keypad
    , "lightbulbOutline" => Ios.lightbulbOutline
    , "lightbulb" => Ios.lightbulb
    , "listOutline" => Ios.listOutline
    , "list" => Ios.list
    , "locationOutline" => Ios.locationOutline
    , "location" => Ios.location
    , "lockedOutline" => Ios.lockedOutline
    , "locked" => Ios.locked
    , "loopStrong" => Ios.loopStrong
    , "loop" => Ios.loop
    , "medicalOutline" => Ios.medicalOutline
    , "medical" => Ios.medical
    , "medkitOutline" => Ios.medkitOutline
    , "medkit" => Ios.medkit
    , "micOff" => Ios.micOff
    , "micOutline" => Ios.micOutline
    , "mic" => Ios.mic
    , "minusEmpty" => Ios.minusEmpty
    , "minusOutline" => Ios.minusOutline
    , "minus" => Ios.minus
    , "monitorOutline" => Ios.monitorOutline
    , "monitor" => Ios.monitor
    , "moonOutline" => Ios.moonOutline
    , "moon" => Ios.moon
    , "moreOutline" => Ios.moreOutline
    , "more" => Ios.more
    , "musicalNote" => Ios.musicalNote
    , "musicalNotes" => Ios.musicalNotes
    , "navigateOutline" => Ios.navigateOutline
    , "navigate" => Ios.navigate
    , "nutritionOutline" => Ios.nutritionOutline
    , "nutrition" => Ios.nutrition
    , "paperOutline" => Ios.paperOutline
    , "paper" => Ios.paper
    , "paperplaneOutline" => Ios.paperplaneOutline
    , "paperplane" => Ios.paperplane
    , "partlySunnyOutline" => Ios.partlySunnyOutline
    , "partlySunny" => Ios.partlySunny
    , "pauseOutline" => Ios.pauseOutline
    , "pause" => Ios.pause
    , "pawOutline" => Ios.pawOutline
    , "paw" => Ios.paw
    , "peopleOutline" => Ios.peopleOutline
    , "people" => Ios.people
    , "personOutline" => Ios.personOutline
    , "person" => Ios.person
    , "personaddOutline" => Ios.personaddOutline
    , "personadd" => Ios.personadd
    , "photosOutline" => Ios.photosOutline
    , "photos" => Ios.photos
    , "pieOutline" => Ios.pieOutline
    , "pie" => Ios.pie
    , "pintOutline" => Ios.pintOutline
    , "pint" => Ios.pint
    , "playOutline" => Ios.playOutline
    , "play" => Ios.play
    , "plusEmpty" => Ios.plusEmpty
    , "plusOutline" => Ios.plusOutline
    , "plus" => Ios.plus
    , "pricetagOutline" => Ios.pricetagOutline
    , "pricetag" => Ios.pricetag
    , "pricetagsOutline" => Ios.pricetagsOutline
    , "pricetags" => Ios.pricetags
    , "printerOutline" => Ios.printerOutline
    , "printer" => Ios.printer
    , "pulseStrong" => Ios.pulseStrong
    , "pulse" => Ios.pulse
    , "rainyOutline" => Ios.rainyOutline
    , "rainy" => Ios.rainy
    , "recordingOutline" => Ios.recordingOutline
    , "recording" => Ios.recording
    , "redoOutline" => Ios.redoOutline
    , "redo" => Ios.redo
    , "refreshEmpty" => Ios.refreshEmpty
    , "refreshOutline" => Ios.refreshOutline
    , "refresh" => Ios.refresh
    , "reload" => Ios.reload
    , "reverseCameraOutline" => Ios.reverseCameraOutline
    , "reverseCamera" => Ios.reverseCamera
    , "rewindOutline" => Ios.rewindOutline
    , "rewind" => Ios.rewind
    , "roseOutline" => Ios.roseOutline
    , "rose" => Ios.rose
    , "searchStrong" => Ios.searchStrong
    , "search" => Ios.search
    , "settingsStrong" => Ios.settingsStrong
    , "settings" => Ios.settings
    , "shuffleStrong" => Ios.shuffleStrong
    , "shuffle" => Ios.shuffle
    , "skipbackwardOutline" => Ios.skipbackwardOutline
    , "skipbackward" => Ios.skipbackward
    , "skipforwardOutline" => Ios.skipforwardOutline
    , "skipforward" => Ios.skipforward
    , "snowy" => Ios.snowy
    , "speedometerOutline" => Ios.speedometerOutline
    , "speedometer" => Ios.speedometer
    , "starHalf" => Ios.starHalf
    , "starOutline" => Ios.starOutline
    , "star" => Ios.star
    , "stopwatchOutline" => Ios.stopwatchOutline
    , "stopwatch" => Ios.stopwatch
    , "sunnyOutline" => Ios.sunnyOutline
    , "sunny" => Ios.sunny
    , "telephoneOutline" => Ios.telephoneOutline
    , "telephone" => Ios.telephone
    , "tennisballOutline" => Ios.tennisballOutline
    , "tennisball" => Ios.tennisball
    , "thunderstormOutline" => Ios.thunderstormOutline
    , "thunderstorm" => Ios.thunderstorm
    , "timeOutline" => Ios.timeOutline
    , "time" => Ios.time
    , "timerOutline" => Ios.timerOutline
    , "timer" => Ios.timer
    , "toggleOutline" => Ios.toggleOutline
    , "toggle" => Ios.toggle
    , "trashOutline" => Ios.trashOutline
    , "trash" => Ios.trash
    , "undoOutline" => Ios.undoOutline
    , "undo" => Ios.undo
    , "unlockedOutline" => Ios.unlockedOutline
    , "unlocked" => Ios.unlocked
    , "uploadOutline" => Ios.uploadOutline
    , "upload" => Ios.upload
    , "videocamOutline" => Ios.videocamOutline
    , "videocam" => Ios.videocam
    , "volumeHigh" => Ios.volumeHigh
    , "volumeLow" => Ios.volumeLow
    , "wineglassOutline" => Ios.wineglassOutline
    , "wineglass" => Ios.wineglass
    , "worldOutline" => Ios.worldOutline
    , "world" => Ios.world
    ]


socialIcons : List ( Tag, Icon msg )
socialIcons =
    [ "androidOutline" => Social.androidOutline
    , "android" => Social.android
    , "angularOutline" => Social.angularOutline
    , "angular" => Social.angular
    , "appleOutline" => Social.appleOutline
    , "apple" => Social.apple
    , "bitcoinOutline" => Social.bitcoinOutline
    , "bitcoin" => Social.bitcoin
    , "bufferOutline" => Social.bufferOutline
    , "buffer" => Social.buffer
    , "chromeOutline" => Social.chromeOutline
    , "chrome" => Social.chrome
    , "codepenOutline" => Social.codepenOutline
    , "codepen" => Social.codepen
    , "css3Outline" => Social.css3Outline
    , "css3" => Social.css3
    , "designernewsOutline" => Social.designernewsOutline
    , "designernews" => Social.designernews
    , "dribbbleOutline" => Social.dribbbleOutline
    , "dribbble" => Social.dribbble
    , "dropboxOutline" => Social.dropboxOutline
    , "dropbox" => Social.dropbox
    , "euroOutline" => Social.euroOutline
    , "euro" => Social.euro
    , "facebookOutline" => Social.facebookOutline
    , "facebook" => Social.facebook
    , "foursquareOutline" => Social.foursquareOutline
    , "foursquare" => Social.foursquare
    , "freebsdDevil" => Social.freebsdDevil
    , "githubOutline" => Social.githubOutline
    , "github" => Social.github
    , "googleOutline" => Social.googleOutline
    , "google" => Social.google
    , "googleplusOutline" => Social.googleplusOutline
    , "googleplus" => Social.googleplus
    , "hackernewsOutline" => Social.hackernewsOutline
    , "hackernews" => Social.hackernews
    , "html5Outline" => Social.html5Outline
    , "html5" => Social.html5
    , "instagramOutline" => Social.instagramOutline
    , "instagram" => Social.instagram
    , "javascriptOutline" => Social.javascriptOutline
    , "javascript" => Social.javascript
    , "linkedinOutline" => Social.linkedinOutline
    , "linkedin" => Social.linkedin
    , "markdown" => Social.markdown
    , "nodejs" => Social.nodejs
    , "octocat" => Social.octocat
    , "pinterestOutline" => Social.pinterestOutline
    , "pinterest" => Social.pinterest
    , "python" => Social.python
    , "redditOutline" => Social.redditOutline
    , "reddit" => Social.reddit
    , "rssOutline" => Social.rssOutline
    , "rss" => Social.rss
    , "sass" => Social.sass
    , "skypeOutline" => Social.skypeOutline
    , "skype" => Social.skype
    , "snapchatOutline" => Social.snapchatOutline
    , "snapchat" => Social.snapchat
    , "tumblrOutline" => Social.tumblrOutline
    , "tumblr" => Social.tumblr
    , "tux" => Social.tux
    , "twitchOutline" => Social.twitchOutline
    , "twitch" => Social.twitch
    , "twitterOutline" => Social.twitterOutline
    , "twitter" => Social.twitter
    , "usdOutline" => Social.usdOutline
    , "usd" => Social.usd
    , "vimeoOutline" => Social.vimeoOutline
    , "vimeo" => Social.vimeo
    , "whatsappOutline" => Social.whatsappOutline
    , "whatsapp" => Social.whatsapp
    , "windowsOutline" => Social.windowsOutline
    , "windows" => Social.windows
    , "wordpressOutline" => Social.wordpressOutline
    , "wordpress" => Social.wordpress
    , "yahooOutline" => Social.yahooOutline
    , "yahoo" => Social.yahoo
    , "yenOutline" => Social.yenOutline
    , "yen" => Social.yen
    , "youtubeOutline" => Social.youtubeOutline
    , "youtube" => Social.youtube
    ]
