import 'package:flutter/material.dart';
import 'library_screen.dart';
import 'store_screen.dart';
import 'player_screen.dart';
import 'models/audiobook.dart';

void main() {
  runApp(const AudiobookApp());
}

class AudiobookApp extends StatefulWidget {
  const AudiobookApp({Key? key}) : super(key: key);

  @override
  State<AudiobookApp> createState() => _AudiobookAppState();
}

class _AudiobookAppState extends State<AudiobookApp> {
  int _selectedIndex = 0;
  List<Audiobook> myLibrary = [];
  Audiobook? currentPlaying;

  // PUBLIC_INTERFACE
  void _onBookPurchased(Audiobook book) {
    setState(() {
      myLibrary.add(book);
      currentPlaying = book;
      _selectedIndex = 2; // Switch to player after purchase
    });
  }

  // PUBLIC_INTERFACE
  void _onBookOpened(Audiobook book) {
    setState(() {
      currentPlaying = book;
      _selectedIndex = 2; // Switch to player tab
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Audiobook Store',
      theme: ThemeData(
        primaryColor: const Color(0xffbadbf7),
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: const Color(0xff583aee)),
        fontFamily: 'Montserrat',
      ),
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          backgroundColor: const Color(0xffbadbf7),
          selectedItemColor: const Color(0xff583aee),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
            BottomNavigationBarItem(icon: Icon(Icons.library_books), label: 'Library'),
            BottomNavigationBarItem(icon: Icon(Icons.play_circle_fill), label: 'Player'),
          ],
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: [
            StoreScreen(onPurchase: _onBookPurchased),
            LibraryScreen(
              myLibrary: myLibrary,
            ),
            if (currentPlaying != null)
              PlayerScreen(audiobook: currentPlaying!)
            else
              Center(
                  child: Text('No audiobook selected', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}
