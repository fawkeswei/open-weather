# README

## Environment
- Xcode 8
- Objective-C
- iOS 9/10
- Universal App

## Note
- Help Screen can be accessed in Settings View
- Open Weather doesn’t have a reliable reverse geocoding api. This app chooses to use iOS’s built in `CLGeocoder`, using the `locality` & `country` property of `CLPlacemark` as the default city name.
- `UIStackView` is available starting iOS 9, therefore deployment target is set to iOS 9 instead of iOS 8.
- Rain Chance isn’t available via the API