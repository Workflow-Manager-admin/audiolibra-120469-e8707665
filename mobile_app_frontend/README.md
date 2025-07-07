# Audiolibra Mobile App Frontend

This is the Flutter frontend implementation of the Audiolibra mobile application. It allows users to browse and purchase audiobooks, manage their personal audiobook library, and play audiobooks with position tracking and skip controls.

## Features

- Audiobook store browsing and search
- Purchase audiobooks via Stripe
- Personal library of purchased audiobooks
- Audiobook playback with position tracking
- 15-second skip forward/back buttons
- Display playback progress
- Local storage of library and playback position

## Project Structure

- `lib/`: All Dart source code
- `assets/`: Images and asset files
- `test/`: Widget and unit tests
- Platform folders: `android/`, `ios/`, `macos/`, `linux/`, `windows/`, `web/`

## Getting Started

1. Install [Flutter](https://flutter.dev/docs/get-started/install).
2. Run `flutter pub get` to fetch dependencies.
3. To run in debug mode: `flutter run`
4. To build for production:  
    - Android: `flutter build apk`
    - iOS: `flutter build ios`
    - Web: `flutter build web`

## Android/iOS Environment

For best compatibility, use recommended NDK and SDK tools:
- Flutter SDK: 3.10+
- Dart: 2.19+
- Android: Use NDK version as specified in project's `build.gradle` and `local.properties`
- iOS: Xcode 14+

If you experience build errors, ensure global Android and iOS tools are installed on your system.

## Configuration Files

- `pubspec.yaml`, `analysis_options.yaml`: Dart/Flutter project configuration.
- `android/`, `ios/`: Platform-specific configuration and build files.

## Troubleshooting

- Clear cached builds if running into issues: `flutter clean`
- Ensure all Flutter plugins and tools are up to date.
- For dependency or build errors, consult [Flutter documentation](https://flutter.dev/docs/get-started/install).

## License

All rights reserved.
