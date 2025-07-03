import 'package:flutter/material.dart';
import 'models/audiobook.dart';

/// AppState holds audiobooks, library state, and purchase logic.
class AppState extends ChangeNotifier {
  // Canonical dummy data for the store
  final List<Audiobook> _storeAudiobooks = [
    Audiobook(
      id: '1984',
      title: '1984',
      author: 'George Orwell',
      coverUrl: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      price: 12.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      description: 'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.',
    ),
    Audiobook(
      id: 'mobydick',
      title: 'Moby Dick',
      author: 'Herman Melville',
      coverUrl: 'https://covers.openlibrary.org/b/id/5551866-L.jpg',
      price: 15.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      description: 'A classic tale of revenge and obsession on the high seas, featuring Captain Ahab and the white whale.',
    ),
    Audiobook(
      id: 'gatsby',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      coverUrl: 'https://covers.openlibrary.org/b/id/7352161-L.jpg',
      price: 10.00,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      description: 'A portrait of the Jazz Age in all of its decadence and excess, told through the eyes of Nick Carraway.',
    ),
    Audiobook(
      id: 'pride',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      coverUrl: 'https://covers.openlibrary.org/b/id/8091016-L.jpg',
      price: 9.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      description: 'A romantic novel of manners that depicts issues of marriage, morality, and misconceptions.',
    ),
  ];

  // The library of audiobooks the user "owns" (add logic as needed)
  final List<Audiobook> purchasedBooks = [];

  // Set of audiobook IDs the user owns (for quick lookup)
  Set<String> get ownedAudiobookIds => purchasedBooks.map((b) => b.id).toSet();

  // Expose store books
  List<Audiobook> get storeAudiobooks => _storeAudiobooks;

  /// --- PLAYER STATE: Current Audiobook being played/selected ---
  Audiobook? _currentBook;
  // PUBLIC_INTERFACE
  Audiobook? get currentBook => _currentBook;
  // PUBLIC_INTERFACE
  void setCurrentBook(Audiobook book, int position) {
    _currentBook = book;
    // Optionally: set playback position logic (not included here)
    notifyListeners();
  }

  /// Add a book to user's library (simulate a purchase)
  void addToLibrary(Audiobook book) {
    if (!purchasedBooks.any((b) => b.id == book.id)) {
      purchasedBooks.add(book);
      notifyListeners();
    }
  }

  // Mock playback positions map (key: book id, value: seconds)
  final Map<String, int> playbackPositions = {};
}
