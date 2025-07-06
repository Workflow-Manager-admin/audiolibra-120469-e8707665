import 'package:flutter/material.dart';
import 'store_screen.dart';
import 'library_screen.dart';

void main() {
  runApp(const MyApp());
}

/// The root of the Audiobook mobile frontend app.
/// PUBLIC_INTERFACE
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colorScheme = ColorScheme.light(
      primary: const Color(0xFFbadbf7),
      secondary: const Color(0xFF583aee),
      onSecondary: Colors.white,
      background: Colors.white,
      surface: Colors.white,
      onPrimary: Colors.black,
      onBackground: Colors.black,
      onSurface: Colors.black,
      error: Colors.red,
      onError: Colors.white,
    );

    final tabs = [
      const StoreScreen(),
      const LibraryScreen(),
    ];

    return MaterialApp(
      title: 'Audiobook App',
      theme: ThemeData(
        colorScheme: colorScheme,
        scaffoldBackgroundColor: colorScheme.background,
        appBarTheme: AppBarTheme(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.black,
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.secondary,
        ),
        textTheme: ThemeData.light().textTheme,
        useMaterial3: false,
      ),
      home: Scaffold(
        body: tabs[_tabIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabIndex,
          onTap: (idx) => setState(() => _tabIndex = idx),
          backgroundColor: colorScheme.primary,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "Store",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Library",
            ),
          ],
          selectedItemColor: colorScheme.secondary,
          unselectedItemColor: colorScheme.secondary.withOpacity(0.5),
          showUnselectedLabels: true,
        ),
      ),
    );
  }
}
