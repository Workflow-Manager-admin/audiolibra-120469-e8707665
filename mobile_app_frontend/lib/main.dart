import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/store_screen.dart';
import 'package:mobile_app_frontend/library_screen.dart';
import 'package:mobile_app_frontend/player_screen.dart';

import 'package:mobile_app_frontend/app_state.dart';
// Provider is required for state management
import 'package:provider/provider.dart';

// PUBLIC_INTERFACE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = await AppState.load();
  runApp(
    ChangeNotifierProvider<AppState>.value(
      value: appState,
      child: const AudiolibraApp(),
    ),
  );
}

/// The main Audiolibra application widget.
class AudiolibraApp extends StatelessWidget {
  // Use super.key for modern style
  const AudiolibraApp({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFFbadbf7);
    const secondaryColor = Color(0xFF583aee);
    const accentColor = Color(0xFFdcb7d9);

    return MaterialApp(
      title: 'Audiolibra',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        colorScheme: const ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Color(0xFF757575), // Colors.grey[600]
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: secondaryColor,
          thumbColor: accentColor,
          // withValues returns a new color with specified alpha (0.1 x 255 for ~10%)
          overlayColor: accentColor.withAlpha((0.1 * 255).toInt()),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            // Use WidgetStatePropertyAll (Flutter >= 3.19.0-0.3.pre) - here we optimistically use it.
            backgroundColor: const WidgetStatePropertyAll<Color>(secondaryColor),
            foregroundColor: const WidgetStatePropertyAll<Color>(Colors.white),
            elevation: const WidgetStatePropertyAll<double>(0),
            shape: WidgetStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: accentColor),
          ),
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The main home screen with bottom navigation and tab management.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      const StoreScreen(),
      const LibraryScreen(),
      const PlayerScreen(), // No arguments, pulls from Provider/AppState
    ];
    return Scaffold(
      body: tabs[_selectedTab],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        onTap: (idx) => setState(() => _selectedTab = idx),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Store',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_books),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_circle),
            label: 'Player',
          ),
        ],
      ),
    );
  }
}
