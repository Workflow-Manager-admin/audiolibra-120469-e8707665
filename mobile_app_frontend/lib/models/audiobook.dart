/// PUBLIC_INTERFACE
/// Represents a complete Audiobook (with chapters), for the audiobook app.
class Audiobook {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String? description;
  final List<AudiobookChapter> chapters;

  // Asset path for cover image (for demo/sample data UI).
  final String? coverAssetPath;

  // Optional tags.
  final List<String>? tags;

  /// PUBLIC_INTERFACE
  /// Audiobook constructor.
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.chapters,
    this.description,
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
