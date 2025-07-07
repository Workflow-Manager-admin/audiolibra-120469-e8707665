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
      durationSeconds: 36000,
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
      durationSeconds: 79224,
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
      durationSeconds: 30482,
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
      durationSeconds: 52052,
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
      durationSeconds: 40000,
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
      durationSeconds: 27000,
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
      durationSeconds: 38760,
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
      durationSeconds: 42000,
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
      durationSeconds: 24420,
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
      durationSeconds: 33780,
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
      durationSeconds: 25000,
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
      durationSeconds: 33075,
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
      durationSeconds: 36000,
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
      durationSeconds: 29900,
    ),
    // Classics with required fields and correct cover URLs
    Audiobook(
      id: 'little_women',
      title: 'Little Women',
      author: 'Louisa May Alcott',
      coverUrl: 'https://th.bing.com/th/id/R.c6fb60a8438cb54090b80ddfc64f7b33?rik=lyBTAyPlRmP1Ow&pid=ImgRaw&r=0',
      price: 9.99,
      description: 'A coming-of-age story about four sisters growing up during the American Civil War.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-7.mp3',
      durationSeconds: 40000,
    ),
    Audiobook(
      id: 'jane_eyre',
      title: 'Jane Eyre',
      author: 'Charlotte Brontë',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.4cds9Zoth2Vd-XkBxV5HMQHaLE?rs=1&pid=ImgDetMain&o=7&rm=3',
      price: 8.99,
      description: 'An orphaned girl becomes a governess and falls in love with her employer.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-8.mp3',
      durationSeconds: 36000,
    ),
    Audiobook(
      id: 'sherlock_holmes',
      title: 'Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      coverUrl: 'https://tu.tv/wp-content/uploads/2019/09/the-adventures-of-sherlock-pdf-download.jpg',
      price: 7.99,
      description: 'A collection of classic detective stories featuring the brilliant Sherlock Holmes.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-9.mp3',
      durationSeconds: 27790,
    ),
    Audiobook(
      id: 'frankenstein',
      title: 'Frankenstein',
      author: 'Mary Shelley',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.hsX0irlDM_aMa-2bLl9ntAHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
      price: 6.99,
      description: 'A scientist creates a sentient creature in this Gothic classic.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-10.mp3',
      durationSeconds: 34000,
    ),
    Audiobook(
      id: 'to_kill_a_mockingbird',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      coverUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_(first_edition_cover).jpg/440px-To_Kill_a_Mockingbird_(first_edition_cover).jpg',
      price: 10.99,
      description: 'A powerful story about racial injustice in the Deep South.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-11.mp3',
      durationSeconds: 41000,
    ),
    Audiobook(
      id: 'war_and_peace',
      title: 'War and Peace',
      author: 'Leo Tolstoy',
      coverUrl: 'https://bookshopnews.com/wp-content/uploads/2024/03/War-and-Peace.jpg',
      price: 12.99,
      description: 'An epic tale of Russian society during the Napoleonic Wars.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-12.mp3',
      durationSeconds: 66000,
    ),
    Audiobook(
      id: 'the_odyssey',
      title: 'The Odyssey',
      author: 'Homer',
      coverUrl: 'https://lythrumpress.com.au/media/2024/10/Artemis-76.webp',
      price: 11.99,
      description: 'The epic journey of Odysseus as he tries to return home from the Trojan War.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-13.mp3',
      durationSeconds: 37500,
    ),
    Audiobook(
      id: 'the_grapes_of_wrath',
      title: 'The Grapes of Wrath',
      author: 'John Steinbeck',
      coverUrl: 'https://th.bing.com/th/id/R.96459894576b2ab3ac2901b9345a8d22?rik=9vNewSGrVVKcMQ&pid=ImgRaw&r=0',
      price: 9.49,
      description: 'A family struggles through the Great Depression while seeking a better life.',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-14.mp3',
      durationSeconds: 32220,
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
