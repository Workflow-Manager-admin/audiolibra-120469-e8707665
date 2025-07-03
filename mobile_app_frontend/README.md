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

## Project structure

- `lib/main.dart` — App entry point, theme, and navigation
- `lib/store_screen.dart` — Audiobook store
- `lib/library_screen.dart` — Purchased audiobooks
- `lib/player_screen.dart` — Audiobook player
- `lib/models/audiobook.dart` — Audiobook model
- `lib/app_state.dart` — State management, local storage

## License

MIT
