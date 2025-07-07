# Audiolibra

A modern, minimalistic Flutter app for browsing, purchasing, and listening to audiobooks.  
- Browse store with search  
- Purchase audiobooks via Stripe (stubbed for demo; implement with Stripe SDK)  
- Persistent local library  
- Full-featured audio playback with 15s skip, progress slider & position memory

## Setup

1. **Install Flutter**
2. `flutter pub get`
3. `flutter run`

## Features

- Store tab: Browse, search, purchase audiobooks
- Library tab: View purchased books
- Player tab: Play audiobooks (resume, skip, position memory)

**Colors:**
- Primary: `#badbf7`
- Secondary: `#583aee`
- Accent: `#dcb7d9`
- Light theme

> _Stripe payment is simulated for demo; to go live follow [Flutter Stripe Payment docs](https://pub.dev/packages/stripe_payment) or use the official [flutter_stripe](https://pub.dev/packages/flutter_stripe) package._

**Local storage:** Hive DB

## Android/NDK Build Troubleshooting

**NDK Failures in CI/Docker**
- The build error `Failed to install the following SDK components: ndk;27.0.12077973` indicates the CI environment is not installing the expected NDK.
- Check your `local.properties` for `ndk.dir` or Android Studio SDK/NDK side-by-side installation.
- The build should NOT hard-pin `ndkVersion` in Gradle unless native code specifically requires it. NDK version can be chosen by CI or the developer machine.
- For CI pipelines or Docker, ensure the following before Gradle/Flutter build:
  - Install the required NDK package using `sdkmanager "ndk;27.0.12077973"` if this exact version is required, or
  - Set up the `ndk.dir` path in `local.properties` to point to the installed NDK root, or
  - If not using NDK, make sure no `ndkVersion` field is present in your gradle files.

**Sample installation in CI:**
```bash
yes | $ANDROID_HOME/cmdline-tools/latest/bin/sdkmanager "ndk;27.0.12077973"
```
or let the build use the system NDK if no specific version is needed.

**Common fix:** If upgrading or downgrading NDK isn't possible due to permissions, remove (comment out) any `ndkVersion` setting from `android/app/build.gradle.kts` and rerun the build.

## Project structure

- `lib/main.dart` — App entry point, theme, and navigation
- `lib/store_screen.dart` — Audiobook store
- `lib/library_screen.dart` — Purchased audiobooks
- `lib/player_screen.dart` — Audiobook player
- `lib/models/audiobook.dart` — Audiobook model
- `lib/app_state.dart` — State management, local storage

## License

MIT
