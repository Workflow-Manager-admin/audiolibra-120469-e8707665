/// PUBLIC_INTERFACE
/// Represents a complete Audiobook for the audiobook app,
/// including all fields needed for store, playback, and display.
class Audiobook {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String description; // Now non-nullable.
  final double price;
  final String sampleUrl;
  final String audioUrl;
  final int durationSeconds;

  // The following are optional or legacy fields; used for future extensibility
  final List<AudiobookChapter>? chapters;
  final String? coverAssetPath;
  final List<String>? tags;

  /// PUBLIC_INTERFACE
  /// Audiobook constructor.
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.sampleUrl,
    required this.audioUrl,
    required this.description,
    required this.durationSeconds,
    this.chapters,
    this.coverAssetPath,
    this.tags,
  });
}

/// PUBLIC_INTERFACE
/// AudiobookChapter: Represents a single chapter (with title, optional desc, and mp4 path/url).
class AudiobookChapter {
  final String title;
  final String? description;
  final String mp4Url;

  // For legacy/demo/sample use - allow alternative name.
  String get mp4PathOrUrl => mp4Url;

  AudiobookChapter({
    required this.title,
    required this.mp4Url,
    this.description,
  });
}
