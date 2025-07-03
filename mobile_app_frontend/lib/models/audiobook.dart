import 'dart:convert';

/// Audiobook data model.
class Audiobook {
  final String id;
  final String title;
  final String author;
  final String coverUrl;
  final String sampleUrl; // MP3 sample
  final String audioUrl;  // Full audiobook (after purchase)
  final double price;

  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverUrl,
    required this.price,
    required this.sampleUrl,
    required this.audioUrl,
  });

  // PUBLIC_INTERFACE
  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['coverUrl'],
      price: (json['price'] as num).toDouble(),
      sampleUrl: json['sampleUrl'],
      audioUrl: json['audioUrl'],
    );
  }

  // PUBLIC_INTERFACE
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'coverUrl': coverUrl,
        'price': price,
        'sampleUrl': sampleUrl,
        'audioUrl': audioUrl,
      };

  static List<Audiobook> listFromJson(String jsonString) {
    final List data = json.decode(jsonString);
    return data.map((j) => Audiobook.fromJson(j)).toList();
  }

  static String listToJson(List<Audiobook> list) {
    return json.encode(list.map((a) => a.toJson()).toList());
  }
}
