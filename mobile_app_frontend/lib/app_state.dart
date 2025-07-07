import 'package:flutter/material.dart';
import 'models/audiobook.dart';

/// AppState holds audiobooks, library state, and purchase logic.
class AppState extends ChangeNotifier {
  // Curated, real and famous audiobooks for the store:
  final List<Audiobook> _storeAudiobooks = [
    Audiobook(
      id: '1984',
      title: '1984',
      author: 'George Orwell',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0',
      price: 12.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      description:
          'A dystopian social science fiction novel and cautionary tale about the dangers of totalitarianism.',
      durationSeconds: 39600, // 11 hours
    ),
    Audiobook(
      id: 'mobydick',
      title: 'Moby Dick',
      author: 'Herman Melville',
      coverUrl: 'https://images.penguinrandomhouse.com/cover/9780143105954',
      price: 15.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      description:
          'A classic tale of revenge and obsession on the high seas, featuring Captain Ahab and the white whale.',
      durationSeconds: 79224, // 22 hours
    ),
    Audiobook(
      id: 'gatsby',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      coverUrl:
          'https://th.bing.com/th/id/R.9e2874738b560052dc4f931a5dd55202?rik=nsFx8BS3ebSyyQ&pid=ImgRaw&r=0',
      price: 10.00,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      description:
          'A portrait of the Jazz Age in all of its decadence and excess, told through the eyes of Nick Carraway.',
      durationSeconds: 18000, // 5 hours
    ),
    Audiobook(
      id: 'pride',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      coverUrl:
          'https://images.squarespace-cdn.com/content/v1/58c180edff7c50dd0e51a2ad/1596042034594-2W8YVTNMCNUDY2FT9G73/Evensen+Creative+Edition+Front.jpg',
      price: 9.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3',
      description:
          'A romantic novel of manners that depicts issues of marriage, morality, and misconceptions.',
      durationSeconds: 52052, // 14.5 hours
    ),
    // Famous real classics and must-reads start here
    Audiobook(
      id: 'tokillamockingbird',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 13.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-5.mp3',
      description:
          "A coming-of-age story set in the American South, exploring justice and empathy through the eyes of young Scout Finch.",
      durationSeconds: 41000,
    ),
    Audiobook(
      id: 'catcherintherye',
      title: 'The Catcher in the Rye',
      author: 'J.D. Salinger',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 12.25,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
      description:
          "Holden Caulfield recounts his days in New York City in this iconic coming-of-age novel.",
      durationSeconds: 25920,
    ),
    Audiobook(
      id: 'hobbit',
      title: 'The Hobbit',
      author: 'J.R.R. Tolkien',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 14.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      description:
          "Bilbo Baggins journeys there and back again in Tolkien's fantasy classic.",
      durationSeconds: 40000,
    ),
    Audiobook(
      id: 'frankenstein',
      title: 'Frankenstein',
      author: 'Mary Shelley',
      coverUrl: 'https://th.bing.com/th/id/OIP.Z9MolIsbuG_uCRLWpfQotwHaLD?w=202&h=302&c=7&r=0&o=7&dpr=1.5&pid=1.7&rm=3', // Frankenstein specific cover
      price: 7.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      description:
          "The original tale of science, creation, and moral consequence, as Victor Frankenstein animates his monster.",
      durationSeconds: 29995,
    ),
    Audiobook(
      id: 'sherlockholmes',
      title: 'The Adventures of Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 9.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      description:
          "Detective Holmes and Dr. Watson unravel the mysteries of Victorian London.",
      durationSeconds: 22000,
    ),
    Audiobook(
      id: 'janeeyre',
      title: 'Jane Eyre',
      author: 'Charlotte Brontë',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 11.79,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      description:
          "Orphaned Jane Eyre overcomes a harsh childhood to find love and independence.",
      durationSeconds: 49700,
    ),
    Audiobook(
      id: 'warandpeace',
      title: 'War and Peace',
      author: 'Leo Tolstoy',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // OpenLibrary
      price: 17.49,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      description:
          "Tolstoy's epic explores love, fate, and the sweep of history during the Napoleonic Wars.",
      durationSeconds: 132000,
    ),
    Audiobook(
      id: 'odyssey',
      title: 'The Odyssey',
      author: 'Homer',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 10.29,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      description:
          "Odysseus's perilous journey home from the Trojan War is chronicled in this foundational classic.",
      durationSeconds: 40200,
    ),
    Audiobook(
      id: 'littlewomen',
      title: 'Little Women',
      author: 'Louisa May Alcott',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 8.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      description:
          "The March sisters grow up in Civil War-era New England with love, ambition, and hope.",
      durationSeconds: 39000,
    ),
    Audiobook(
      id: 'grapesofwrath',
      title: 'The Grapes of Wrath',
      author: 'John Steinbeck',
      coverUrl: 'https://th.bing.com/th/id/R.47b039453a21e68e86662c235471ba6c?rik=BljL6TcOpXxaPQ&pid=ImgRaw&r=0', // General cover image
      price: 12.99,
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      description:
          "The Joad family migrates west during the Great Depression in this classic of American literature.",
      durationSeconds: 67000,
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
