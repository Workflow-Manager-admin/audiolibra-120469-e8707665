import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/store_screen.dart';
import 'package:mobile_app_frontend/library_screen.dart';
import 'package:mobile_app_frontend/player_screen.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';
import 'package:mobile_app_frontend/app_state.dart';

// PUBLIC_INTERFACE
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appState = await AppState.load();
  runApp(AudiolibraApp(appState: appState));
}

/// The main Audiolibra application widget.
class AudiolibraApp extends StatelessWidget {
  final AppState appState;

  const AudiolibraApp({required this.appState, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final primaryColor = const Color(0xFFbadbf7);
    final secondaryColor = const Color(0xFF583aee);
    final accentColor = const Color(0xFFdcb7d9);

    return MaterialApp(
      title: 'Audiolibra',
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
          tertiary: accentColor,
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: primaryColor,
          foregroundColor: Colors.black87,
          elevation: 0,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white,
          selectedItemColor: secondaryColor,
          unselectedItemColor: Colors.grey[600],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        ),
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontWeight: FontWeight.bold),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: secondaryColor,
          thumbColor: accentColor,
          overlayColor: accentColor.withOpacity(0.1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(secondaryColor),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            elevation: MaterialStatePropertyAll(0),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: accentColor),
          ),
        ),
      ),
      home: HomeScreen(appState: appState),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The main home screen with bottom navigation and tab management.
class HomeScreen extends StatefulWidget {
  final AppState appState;
  const HomeScreen({required this.appState, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedTab = 0;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      StoreScreen(appState: widget.appState),
      LibraryScreen(appState: widget.appState),
      PlayerScreen(appState: widget.appState),
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
