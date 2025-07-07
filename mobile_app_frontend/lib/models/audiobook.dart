class Audiobook {
  final String id;
  final String title;
  final String author;
  final String coverAsset;

  Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.coverAsset,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Audiobook &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
