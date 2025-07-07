/// Chapter model representing a playable mp4 for an audiobook chapter.
class AudiobookChapter {
  final String title;
  final String mp4PathOrUrl;

  // PUBLIC_INTERFACE
  AudiobookChapter({
    required this.title,
    required this.mp4PathOrUrl,
  });
}

/// Enhanced Audiobook data model supporting chapters for chapter-based playback.
/// Chapters are represented as a list of AudiobookChapter objects.
class Audiobook {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final List<String> tags;
  final String description;
  final List<AudiobookChapter> chapters;
  final String coverAssetPath;
  final double price;

  // PUBLIC_INTERFACE
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.tags,
    required this.description,
    required this.chapters,
    required this.coverAssetPath,
    required this.price,
  });
}
