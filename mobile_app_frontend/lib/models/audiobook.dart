import 'dart:convert';

/// Audiobook data model.
/// When using demo/dummy data, ensure that audioUrl points to a valid public MP3 file,
/// such as: https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3 for testing audio playback.
class Audiobook {
  /// Unique identifier for the audiobook.
  final String id;

  /// Title of the audiobook.
  final String title;

  /// Author of the audiobook.
  final String author;

  /// Cover image URL of the audiobook.
  final String coverUrl;

  /// URL to a sample audio.
  final String sampleUrl;

  /// URL to the full audiobook audio (after purchase).
  /// Example for dummy data:
  /// audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3"
  final String audioUrl;

  /// Price of the audiobook.
  final double price;

  /// Description of the audiobook (non-nullable).
  final String description;

  // PUBLIC_INTERFACE
  /// Creates an [Audiobook].
  /// [description] is a required, non-nullable field describing the audiobook.
  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.sampleUrl,
    required this.audioUrl,
    required this.description,
  });

  // PUBLIC_INTERFACE
  /// Creates an [Audiobook] instance from a JSON map.
  // PUBLIC_INTERFACE
  /// Creates an [Audiobook] instance from a JSON map, with robust handling for missing/invalid audioUrl.
  factory Audiobook.fromJson(Map<String, dynamic> json) {
    // Use a test/fallback MP3 for any missing/invalid audioUrl.
    const fallbackUrl = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3";
    final parsedAudioUrl = json['audioUrl'] ?? "";
    String audioUrlToUse = parsedAudioUrl;
    if (parsedAudioUrl.isEmpty ||
        !(parsedAudioUrl.startsWith("http://") || parsedAudioUrl.startsWith("https://")) ||
        !parsedAudioUrl.toLowerCase().endsWith(".mp3")) {
      // ignore: avoid_print
      print(
          "[Audiobook.fromJson] WARNING: Malformed or missing audioUrl: '$parsedAudioUrl' for book '${json['title']}'. Using fallback URL.");
      audioUrlToUse = fallbackUrl;
    }
    return Audiobook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      price: (json['price'] as num).toDouble(),
      sampleUrl: json['sampleUrl'],
      audioUrl: audioUrlToUse,
      description: json['description'],
    );
  }

  // PUBLIC_INTERFACE
  /// Returns a JSON map representing this [Audiobook].
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'price': price,
        'sampleUrl': sampleUrl,
        'audioUrl': audioUrl,
        'description': description,
      };

  static List<Audiobook> listFromJson(String jsonString) {
    final List data = json.decode(jsonString);
    return data.map((j) => Audiobook.fromJson(j)).toList();
  }

  static String listToJson(List<Audiobook> list) {
    return json.encode(list.map((a) => a.toJson()).toList());
  }
}
