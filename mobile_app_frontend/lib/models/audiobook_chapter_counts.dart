/// Mapping of book titles (as used in store/library) to their chapter counts.
/// Use this to provide chapter-based playback UI in the audiobook player.
/// Expand as more audiobooks get added.
const Map<String, int> audiobookChapterCounts = {
  // Classic Novels
  '1984': 23, // George Orwell's novel has 3 parts, 23 chapters
  'Moby Dick': 135, // 135 chapters + Epilogue
  'Pride and Prejudice': 61,
  'The Great Gatsby': 9,
  'Little Women': 47, // Part One + Part Two combined (standard US edition)
  'Jane Eyre': 38,
  'Frankenstein': 24,
  'To Kill a Mockingbird': 31,
  'War and Peace': 365,
  'The Odyssey': 24,
  'The Grapes of Wrath': 30,
  // Sherlock Holmes books/collections (main examples)
  'Sherlock Holmes: The Adventures': 12, // 12 stories
  'Sherlock Holmes: The Memoirs': 11,
  'Sherlock Holmes: The Return': 13,
  'Sherlock Holmes: His Last Bow': 8,
  'Sherlock Holmes: The Case-Book': 12,
};

/// If additional or alternate versions are in store, add them here with exact store/library display title.
/// For multi-volume, multi-story, or poetry books, use the chapter/story count as presented in the audio files.
