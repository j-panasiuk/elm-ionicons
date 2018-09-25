# Changelog

## 2.0.0

Upgrade to Elm 0.19
- Color of an icon is now a record `{ red: Int, green: Int, blue: Int, alpha: Float }` as core `Color` module doesn't exist anymore

Other changes
- Color values are clamped to 0-255 range
- Alpha value is clamped to 0-1 range

## 1.0.0

Initial release