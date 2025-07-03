import 'dart:convert';

/// Audiobook data model.
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
  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      price: (json['price'] as num).toDouble(),
      sampleUrl: json['sampleUrl'],
      audioUrl: json['audioUrl'],
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
