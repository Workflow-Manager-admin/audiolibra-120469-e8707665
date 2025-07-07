import 'package:flutter/material.dart';
import 'models/audiobook.dart';
import 'player_screen.dart';

/// The user's audiobook library, with navigation to chapter-based player.
class LibraryScreen extends StatelessWidget {
  final List<Audiobook>? myLibrary;

  // PUBLIC_INTERFACE
  const LibraryScreen({
    Key? key,
    this.myLibrary,
  }) : super(key: key);

  // Demo/fallback data for local demo/testing.
  static List<Audiobook> sampleLibrary = [
    Audiobook(
      id: '1',
      title: "Moby Dick",
      author: "Herman Melville",
      coverUrl: "",
      tags: ["classic", "adventure"],
      description: "A classic novel about the adventures aboard the Pequod.",
      chapters: [
        AudiobookChapter(
            title: "Chapter 1: Loomings", mp4Url: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"),
        AudiobookChapter(
            title: "Chapter 2: The Carpet-Bag", mp4Url: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"),
        AudiobookChapter(
            title: "Chapter 3: The Spouter-Inn", mp4Url: "https://sample-videos.com/video123/mp4/720/big_buck_bunny_720p_1mb.mp4"),
      ],
      coverAssetPath: "assets/moby_dick_cover.jpg",
    ),
  ];

  // PUBLIC_INTERFACE
  void _openBook(BuildContext context, Audiobook book) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => PlayerScreen(audiobook: book),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final List<Audiobook> library = myLibrary ?? sampleLibrary;
    return ListView.builder(
      itemCount: library.length,
      itemBuilder: (context, index) {
        final book = library[index];
        return ListTile(
          leading: book.coverAssetPath != null
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    book.coverAssetPath!,
                    height: 48,
                    width: 48,
                    fit: BoxFit.cover,
                  ),
                )
              : Icon(Icons.library_music, size: 48, color: Theme.of(context).primaryColor),
          title: Text(book.title),
          subtitle: Text(book.author),
          trailing: const Icon(Icons.chevron_right),
          onTap: () => _openBook(context, book),
        );
      },
    );
  }
}
