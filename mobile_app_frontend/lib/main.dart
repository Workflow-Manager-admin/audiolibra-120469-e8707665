import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'store_screen.dart';
import 'library_screen.dart';
import 'player_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const AudiolibraApp(),
    ),
  );
}

class AudiolibraApp extends StatelessWidget {
  const AudiolibraApp({Key? key}) : super(key: key);

  static const primaryColor = Color(0xffbadbf7);
  static const secondaryColor = Color(0xff583aee);
  static const accentColor = Color(0xffdcb7d9);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audiolibra',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: primaryColor,
        colorScheme: ColorScheme.light(
          primary: primaryColor,
          secondary: secondaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: primaryColor,
        ),
        useMaterial3: true,
      ),
      home: const MainNavigation(),
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({Key? key}) : super(key: key);

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    StoreScreen(),
    LibraryScreen(),
    PlayerScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: AudiolibraApp.secondaryColor,
        unselectedItemColor: Colors.black38,
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
            icon: Icon(Icons.play_arrow),
            label: 'Player',
          ),
        ],
        onTap: (int i) => setState(() => _currentIndex = i),
      ),
    );
  }
}
