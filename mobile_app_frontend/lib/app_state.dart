import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';
import 'package:path_provider/path_provider.dart';

/// Dummy audiobooks for the store (at least 8+ entries with image URLs),
/// Each with a description.
final List<Audiobook> dummyStoreAudiobooks = [
  Audiobook(
    id: '1',
    title: 'Moby Dick',
    author: 'Herman Melville',
    coverUrl: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
    price: 12.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'An epic tale of obsession, vengeance, and the struggle against nature, as Captain Ahab hunts the white whale.',
  ),
  Audiobook(
    id: '2',
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    coverUrl: 'https://covers.openlibrary.org/b/id/8231993-L.jpg',
    price: 11.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'A witty commentary on social status and marriage among the British gentry of the early 19th century.',
  ),
  Audiobook(
    id: '3',
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    coverUrl: 'https://covers.openlibrary.org/b/id/11122210-L.jpg',
    price: 13.49,
    sampleUrl: '',
    audioUrl: '',
    description: 'A classic novel set in the Roaring Twenties exploring decadence, idealism, and the American dream.',
  ),
  Audiobook(
    id: '4',
    title: 'Frankenstein',
    author: 'Mary Shelley',
    coverUrl: 'https://covers.openlibrary.org/b/id/10354117-L.jpg',
    price: 10.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'A story of scientific hubris and unintended consequences, as Victor Frankenstein creates a living monster.',
  ),
  Audiobook(
    id: '5',
    title: 'Dracula',
    author: 'Bram Stoker',
    coverUrl: 'https://covers.openlibrary.org/b/id/10414109-L.jpg',
    price: 9.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'The legendary tale of Count Dracula and his dark quest for blood, told through journal entries and letters.',
  ),
  Audiobook(
    id: '6',
    title: 'The Adventures of Sherlock Holmes',
    author: 'Arthur Conan Doyle',
    coverUrl: 'https://covers.openlibrary.org/b/id/8712161-L.jpg',
    price: 10.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'A collection of classic Sherlock Holmes mysteries, blurring logic, deduction, and excitement.',
  ),
  Audiobook(
    id: '7',
    title: 'Treasure Island',
    author: 'Robert Louis Stevenson',
    coverUrl: 'https://covers.openlibrary.org/b/id/6979861-L.jpg',
    price: 8.89,
    sampleUrl: '',
    audioUrl: '',
    description: 'A tale of pirates, treasure maps, and adventure on the high seas for young Jim Hawkins.',
  ),
  Audiobook(
    id: '8',
    title: 'The Art of War',
    author: 'Sun Tzu',
    coverUrl: 'https://covers.openlibrary.org/b/id/10523386-L.jpg',
    price: 7.99,
    sampleUrl: '',
    audioUrl: '',
    description: 'An ancient Chinese military treatise on strategy, tactics, and leadership—still influential today.',
  ),
  Audiobook(
    id: '9',
    title: 'Jane Eyre',
    author: 'Charlotte Brontë',
    coverUrl: 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
    price: 12.49,
    sampleUrl: '',
    audioUrl: '',
    description: 'A deeply emotional journey of growth, independence, and love against the odds for orphan Jane.',
  ),
];

/// App state management for user library and playback
class AppState extends ChangeNotifier {
  static const libraryBoxName = 'libraryBox_v1';
  static const playbackBoxName = 'playbackBox_v1';

  List<Audiobook> purchasedBooks = [];
  Map<String, double> playbackPositions = {}; // audiobookId -> position (seconds)
  Audiobook? currentBook;
  double? currentPosition;

  late Box libraryBox;
  late Box playbackBox;

  AppState();

  /// Store audiobooks getter to mimic previous API for StoreScreen/grid version
  List<Audiobook> get storeAudiobooks => dummyStoreAudiobooks;

  /// Returns IDs of purchased audiobooks for grid variant
  Set<String> get ownedAudiobookIds => purchasedBooks.map((b) => b.id).toSet();

  /// Load state from local storage
  // PUBLIC_INTERFACE
  static Future<AppState> load() async {
    final docDir = await getApplicationDocumentsDirectory();
    Hive.init(docDir.path);

    final libraryBox = await Hive.openBox(libraryBoxName);
    final playbackBox = await Hive.openBox(playbackBoxName);

    final state = AppState();
    state.libraryBox = libraryBox;
    state.playbackBox = playbackBox;

    final purchasedJson = libraryBox.get('purchased', defaultValue: '[]');
    state.purchasedBooks = Audiobook.listFromJson(purchasedJson);

    final playbackJson = playbackBox.get('positions', defaultValue: '{}');
    final Map<String, dynamic> positionsMap =
        json.decode(playbackJson is String ? playbackJson : '{}');
    state.playbackPositions =
        positionsMap.map((k, v) => MapEntry(k, (v as num).toDouble()));

    // Load current book if set
    final currentBookJson = playbackBox.get('currentBook', defaultValue: null);
    if (currentBookJson != null) {
      state.currentBook = Audiobook.fromJson(json.decode(currentBookJson));
    }
    state.currentPosition =
        (playbackBox.get('currentPosition', defaultValue: null) as num?)?.toDouble();

    return state;
  }

  /// Add a purchased audiobook to the library, save to local storage
  // PUBLIC_INTERFACE
  void addToLibrary(Audiobook book) {
    if (!purchasedBooks.any((b) => b.id == book.id)) {
      purchasedBooks.add(book);
      libraryBox.put('purchased', Audiobook.listToJson(purchasedBooks));
      notifyListeners();
    }
  }

  /// Set and persist the current playing audiobook
  // PUBLIC_INTERFACE
  void setCurrentBook(Audiobook book, [double pos = 0]) {
    currentBook = book;
    currentPosition = pos;
    playbackBox.put('currentBook', json.encode(book.toJson()));
    playbackBox.put('currentPosition', pos);
    notifyListeners();
  }

  /// Update and persist playback position for a particular audiobook
  // PUBLIC_INTERFACE
  void updatePlaybackPosition(String id, double position) {
    playbackPositions[id] = position;
    playbackBox.put('positions', json.encode(playbackPositions));
    if (currentBook?.id == id) {
      currentPosition = position;
      playbackBox.put('currentPosition', position);
    }
    notifyListeners();
  }
}
