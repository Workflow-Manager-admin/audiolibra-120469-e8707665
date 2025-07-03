import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';
import 'package:path_provider/path_provider.dart';

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
