import 'package:flutter/material.dart';
import 'models/audiobook.dart';

/// AppState holds audiobooks, library state, and purchase logic.
class AppState extends ChangeNotifier {
  // Store audiobooks (available for browsing/purchase) - UPDATED TO SPEC
  final List<Audiobook> _storeAudiobooks = [
    // --- Classics to restore ---
    Audiobook(
      id: '1984',
      title: '1984',
      author: 'George Orwell',
      coverUrl: 'https://images.thalia.media/07/-/cbed699587704a8a9bc0a1e96b90493f/1984-gebundene-ausgabe-george-orwell.jpeg', // Updated to correct external URL
      price: 9.99,
      sampleUrl: '',
      audioUrl: '',
      description: 'A dystopian classic of surveillance, control, and rebellion. Placeholder description.',
      durationSeconds: 43000, // Placeholder ~12:00
    ),
    Audiobook(
      id: 'mobydick',
      title: 'Moby Dick',
      author: 'Herman Melville',
      coverUrl: 'https://images.randomhouse.com/cover/9780143105954', // Updated to correct external URL
      price: 8.49,
      sampleUrl: '',
      audioUrl: '',
      description: "Captain Ahab's obsessive quest for the elusive white whale. Placeholder description.",
      durationSeconds: 79000, // Placeholder ~22:00
    ),
    Audiobook(
      id: 'prideandprejudice',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      coverUrl: 'https://tse4.mm.bing.net/th/id/OIP.g7a3ggdb6yPVZ0iLmYQi-gHaK_?rs=1&pid=ImgDetMain&o=7&rm=3', // Updated to correct external URL
      price: 7.99,
      sampleUrl: '',
      audioUrl: '',
      description: 'A witty romance about manners, marriage, and society. Placeholder description.',
      durationSeconds: 41000, // Placeholder ~11:00
    ),
    Audiobook(
      id: 'thegreatgatsby',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      coverUrl: 'https://tse4.mm.bing.net/th/id/OIP.uBeGOh6Ir7HpGap_TsorEQHaKf?rs=1&pid=ImgDetMain&o=7&rm=3', // Updated to correct external URL
      price: 8.99,
      sampleUrl: '',
      audioUrl: '',
      description: 'A novel of the Jazz Age and the elusive American Dream. Placeholder description.',
      durationSeconds: 27000, // Placeholder ~7:30
    ),
    // --- Existing/new books retained; do not duplicate ---
    Audiobook(
      id: 'littlewomen',
      title: 'Little Women',
      author: 'Louisa May Alcott',
      coverUrl: 'https://th.bing.com/th/id/R.c6fb60a8438cb54090b80ddfc64f7b33?rik=lyBTAyPlRmP1Ow&pid=ImgRaw&r=0',
      price: 8.99,
      sampleUrl: '', // Placeholder
      audioUrl: '', // Placeholder
      description: 'A timeless classic following the four March sisters as they navigate love, family, and finding their own place in the world.',
      durationSeconds: 39000, // placeholder ~10:50
    ),
    Audiobook(
      id: 'janeeyre',
      title: 'Jane Eyre',
      author: 'Charlotte Brontë',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.4cds9Zoth2Vd-XkBxV5HMQHaLE?rs=1&pid=ImgDetMain&o=7&rm=3',
      price: 7.99,
      sampleUrl: '',
      audioUrl: '',
      description: 'The journey of a strong-willed orphan, her trials, passions, and triumphs.',
      durationSeconds: 49700, // placeholder ~13:48
    ),
    Audiobook(
      id: 'sherlockholmes',
      title: 'Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      coverUrl: 'https://tu.tv/wp-content/uploads/2019/09/the-adventures-of-sherlock-pdf-download.jpg',
      price: 8.49,
      sampleUrl: '',
      audioUrl: '',
      description: "Detective Sherlock Holmes and Dr. Watson solve the world’s most mysterious cases.",
      durationSeconds: 22000, // placeholder ~6:06
    ),
    Audiobook(
      id: 'frankenstein',
      title: 'Frankenstein',
      author: 'Mary Shelley',
      coverUrl: 'https://tse2.mm.bing.net/th/id/OIP.hsX0irlDM_aMa-2bLl9ntAHaLH?rs=1&pid=ImgDetMain&o=7&rm=3',
      price: 7.49,
      sampleUrl: '',
      audioUrl: '',
      description: 'A gothic tale of a scientist whose quest for knowledge leads to tragic consequences.',
      durationSeconds: 29995, // placeholder ~8:20
    ),
    Audiobook(
      id: 'tokillamockingbird',
      title: 'To Kill a Mockingbird',
      author: 'Harper Lee',
      coverUrl: 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4f/To_Kill_a_Mockingbird_(first_edition_cover).jpg/440px-To_Kill_a_Mockingbird_(first_edition_cover).jpg',
      price: 9.49,
      sampleUrl: '',
      audioUrl: '',
      description: 'A young girl’s coming of age in the racially charged American South.',
      durationSeconds: 41000, // placeholder ~11:23
    ),
    Audiobook(
      id: 'warandpeace',
      title: 'War and Peace',
      author: 'Leo Tolstoy',
      coverUrl: 'https://bookshopnews.com/wp-content/uploads/2024/03/War-and-Peace.jpg',
      price: 11.99,
      sampleUrl: '',
      audioUrl: '',
      description: 'An epic story of love, fate, and war in 19th-century Russia.',
      durationSeconds: 132000, // placeholder ~36:40
    ),
    Audiobook(
      id: 'odyssey',
      title: 'The Odyssey',
      author: 'Homer',
      coverUrl: 'https://lythrumpress.com.au/media/2024/10/Artemis-76.webp',
      price: 8.79,
      sampleUrl: '',
      audioUrl: '',
      description: "Odysseus’s ten-year journey home after the Trojan War, filled with adventure.",
      durationSeconds: 40200, // placeholder ~11:10
    ),
    Audiobook(
      id: 'grapesofwrath',
      title: 'The Grapes of Wrath',
      author: 'John Steinbeck',
      coverUrl: 'https://th.bing.com/th/id/R.96459894576b2ab3ac2901b9345a8d22?rik=9vNewSGrVVKcMQ&pid=ImgRaw&r=0',
      price: 8.20,
      sampleUrl: '',
      audioUrl: '',
      description: "An American classic chronicling a family’s struggle during the Great Depression.",
      durationSeconds: 67000, // placeholder ~18:36
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
