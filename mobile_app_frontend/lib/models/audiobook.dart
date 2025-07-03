import 'dart:convert';

/// Audiobook data model with duration for realistic playback UI.
/// Ensure audioUrl points to a public MP3 for testing/demo.
class Audiobook {
  /// Unique identifier for the audiobook.
  final String id;

  /// Title of the audiobook.
  final String title;

  /// Author
  final String author;

  /// Cover image URL.
  final String coverUrl;

  /// URL to a sample audio.
  final String sampleUrl;

  /// URL to the full (purchased) audio.
  final String audioUrl;

  /// Price of the audiobook.
  final double price;

  /// Description of the audiobook.
  final String description;

  /// Realistic total duration in seconds (required for progress bar).
  final int durationSeconds;

  // PUBLIC_INTERFACE
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.sampleUrl,
    required this.audioUrl,
    required this.price,
    required this.description,
    required this.durationSeconds,
  });

  // PUBLIC_INTERFACE
  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      sampleUrl: json['sampleUrl'],
      audioUrl: json['audioUrl'] ??
          "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      price: (json['price'] as num).toDouble(),
      description: json['description'],
      durationSeconds: json['durationSeconds'] ??
          3600, // Default to 1 hour if missing for robustness
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'sampleUrl': sampleUrl,
        'audioUrl': audioUrl,
        'price': price,
        'description': description,
        'durationSeconds': durationSeconds,
      };

  /// Dummy data for demonstration with explicit durations.
  static List<Audiobook> dummyAudiobooks = [
    Audiobook(
      id: '1',
      title: 'The Adventures of Sherlock Holmes',
      author: 'Arthur Conan Doyle',
      coverUrl: 'https://covers.openlibrary.org/b/id/8226096-L.jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      price: 9.99,
      description: 'A tale of mystery with Sherlock Holmes.',
      durationSeconds: 27790, // 7:43:10
    ),
    Audiobook(
      id: '2',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      coverUrl: 'https://covers.openlibrary.org/b/id/8091016-L.jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
      price: 8.99,
      description: 'A romantic classic.',
      durationSeconds: 52052, // 14:27:32
    ),
    Audiobook(
      id: '3',
      title: 'Moby Dick',
      author: 'Herman Melville',
      coverUrl: 'https://covers.openlibrary.org/b/id/7222246-L.jpg',
      sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
      price: 10.99,
      description: 'A classic sea adventure.',
      durationSeconds: 79224, // 22:00:24
    ),
  ];
}
