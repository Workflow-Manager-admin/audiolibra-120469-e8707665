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

  // Example "store" audiobooks. Replace/add as needed.
  final List<Audiobook> storeBooks = [
    Audiobook(
      id: '1',
      title: 'Moby Dick',
      author: 'Herman Melville',
      coverUrl: 'https://upload.wikimedia.org/wikipedia/commons/4/41/Moby-Dick_FE_title_page.jpg',
      audioUrl: 'https://www.sample-videos.com/audio/mp3/wave.mp3',
      price: 14.99,
      description: 'A thrilling sea adventure and classic American novel.',
    ),
    Audiobook(
      id: '2',
      title: 'Frankenstein',
      author: 'Mary Shelley',
      coverUrl: 'https://upload.wikimedia.org/wikipedia/commons/6/66/Frankenstein_1818_edition_title_page.jpg',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      price: 12.49,
      description: 'The chilling tale of a genius inventor and his terrifying creation.',
    ),
  ];

  List<Audiobook> myLibrary = [];
  Audiobook? currentPlaying;

  // PUBLIC_INTERFACE
  void _onBookPurchased(Audiobook book) {
    setState(() {
      if (!myLibrary.any((b) => b.id == book.id)) {
        myLibrary.add(book);
      }
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
    final Set<String> ownedIds = myLibrary.map((b) => b.id).toSet();

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
            StoreScreen(
              onPurchase: _onBookPurchased,
              storeBooks: storeBooks,
              ownedIds: ownedIds,
            ),
            LibraryScreen(
              myLibrary: myLibrary,
              onOpen: _onBookOpened,
            ),
            if (currentPlaying != null)
              PlayerScreen(audiobook: currentPlaying!)
            else
              const Center(
                  child: Text('No audiobook selected', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}
