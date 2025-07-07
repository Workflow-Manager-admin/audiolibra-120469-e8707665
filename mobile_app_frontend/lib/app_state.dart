import 'package:flutter/material.dart';
import 'models/audiobook.dart';

class AppState extends ChangeNotifier {
  List<Audiobook> _library = [];
  Audiobook? _currentBook;
  Duration _playbackPosition = Duration.zero;

  List<Audiobook> get library => _library;
  Audiobook? get currentBook => _currentBook;
  Duration get playbackPosition => _playbackPosition;

  void setLibrary(List<Audiobook> books) {
    _library = books;
    notifyListeners();
  }

  void addToLibrary(Audiobook book) {
    if (!_library.contains(book)) {
      _library.add(book);
      notifyListeners();
    }
  }

  void setCurrentBook(Audiobook? book) {
    _currentBook = book;
    _playbackPosition = Duration.zero;
    notifyListeners();
  }

  void setPlaybackPosition(Duration position) {
    _playbackPosition = position;
    notifyListeners();
  }
}
