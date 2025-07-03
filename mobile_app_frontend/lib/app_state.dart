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
      durationSeconds: 39600, // 11 hours
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
      durationSeconds: 79224, // 22 hours
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
      durationSeconds: 18000, // 5 hours
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
      durationSeconds: 52052, // 14.5 hours
    ),
    // --- New Dummy Books Below ---
    Audiobook(
      id: 'adventure-begins',
      title: 'The Adventure Begins',
      author: 'Jane Doe',
      coverUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 11.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      description: 'A heart-pounding journey of discovery and courage set in a mysterious world.',
      durationSeconds: 20800, // ~5.8 hours
    ),
    Audiobook(
      id: 'mystery-clock',
      title: 'Mystery of the Old Clock',
      author: 'John Smith',
      coverUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 8.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      description: 'When an old clock goes missing in a sleepy town, secrets unravel and friendships are tested.',
      durationSeconds: 14100, // ~3.9 hours
    ),
    Audiobook(
      id: 'galactic-voyages',
      title: 'Galactic Voyages',
      author: 'Sarah Newton',
      coverUrl: 'https://images.unsplash.com/photo-1465101046530-73398c7f28ca?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 13.29,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      description: 'Join Captain Reyes as they explore far-off galaxies and confront cosmic dangers.',
      durationSeconds: 37200, // 10.3 hours
    ),
    Audiobook(
      id: 'crimson-sky',
      title: 'Under the Crimson Sky',
      author: 'Liam Shepherd',
      coverUrl: 'https://images.unsplash.com/photo-1470770841072-f978cf4d019e?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 14.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      description: 'A sweeping historical drama of love, loss, and hope in war-torn landscapes.',
      durationSeconds: 28100, // ~7.8 hours
    ),
    Audiobook(
      id: 'whispers-wind',
      title: 'Whispers of the Wind',
      author: 'Emily Brontë',
      coverUrl: 'https://images.unsplash.com/photo-1482062364825-616fd23b8fc1?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 10.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      description: 'Poignant poetic tales that drift on the breath of the moors.',
      durationSeconds: 15000, // ~4.2 hours
    ),
    Audiobook(
      id: 'last-alchemist',
      title: 'The Last Alchemist',
      author: 'David K. Marshall',
      coverUrl: 'https://images.unsplash.com/photo-1521737852567-6949f3f9f2b5?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 13.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      description: 'A tale of ancient secrets, modern dangers, and the quest for a lost formula.',
      durationSeconds: 31200, // 8.7 hours
    ),
    Audiobook(
      id: 'silent-streets',
      title: 'Silent Streets',
      author: 'Nina Larsson',
      coverUrl: 'https://images.unsplash.com/photo-1499346030926-9a72daac6c63?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 8.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      description: 'Urban noir at its finest, where the shadows whisper and justice is hard-won.',
      durationSeconds: 11000, // ~3.1 hours
    ),
    Audiobook(
      id: 'ocean-dreams',
      title: 'Ocean of Dreams',
      author: 'Carlos Rios',
      coverUrl: 'https://images.unsplash.com/photo-1444065381814-865dc9da92c0?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 12.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      description: 'A magical realism journey where the ocean waves hold memories and futures.',
      durationSeconds: 17490, // ~4.8 hours
    ),
    Audiobook(
      id: 'ancient-gates',
      title: 'Through the Ancient Gates',
      author: 'Priya Patel',
      coverUrl: 'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 13.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      description: 'Fantasy adventure into long-lost realms inspired by ancient Asian folklore.',
      durationSeconds: 20300, // ~5.6 hours
    ),
    Audiobook(
      id: 'edge-reality',
      title: 'Edge of Reality',
      author: 'Oliver Yu',
      coverUrl: 'https://images.unsplash.com/photo-1516979187457-637abb4f9353?auto=format&fit=facearea&w=400&h=600&facepad=2&q=80',
      price: 11.29,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      description: 'Science, conspiracy, and heart-pounding thriller at the boundary of the unknown.',
      durationSeconds: 18920, // ~5.3 hours
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
