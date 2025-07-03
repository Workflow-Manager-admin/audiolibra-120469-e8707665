import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/app_state.dart';
import 'package:provider/provider.dart';

/// The user's audiobook library (purchased books).
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final books = appState.purchasedBooks;

    String getImageUrl(dynamic book) {
      // Try known possible fields, fall back to placeholder
      try {
        final dynamic imageUrl = book.coverImageUrl;
        if (imageUrl is String && imageUrl.isNotEmpty) return imageUrl;
      } catch (_) {}
      try {
        final dynamic imageUrl = book.coverUrl;
        if (imageUrl is String && imageUrl.isNotEmpty) return imageUrl;
      } catch (_) {}
      try {
        final dynamic imageUrl = book.audioUrl;
        if (imageUrl is String && (imageUrl.endsWith('.jpg') || imageUrl.endsWith('.png'))) return imageUrl;
      } catch (_) {}
      return 'assets/covers/placeholder.jpg';
    }

    return Padding(
      padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Library',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          if (books.isEmpty)
            Expanded(
              child: Center(
                child: Text(
                  "No audiobooks purchased yet.\nGo to the Store to find your next listen!",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemCount: books.length,
                separatorBuilder: (_, __) => const Divider(height: 24),
                itemBuilder: (_, idx) {
                  final book = books[idx];
                  final String imageUrl = getImageUrl(book);

                  return ListTile(
                    leading: AspectRatio(
                      aspectRatio: 1 / 1.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            color: Colors.grey[200],
                            child: const Center(
                              child: Icon(Icons.book,
                                  size: 54, color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(book.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 16)),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(book.author),
                        const SizedBox(height: 3),
                        Text(
                          book.description,
                          style: TextStyle(
                              fontSize: 12, color: Colors.grey[600]),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.play_circle,
                        color: Theme.of(context).colorScheme.secondary),
                    onTap: () {
                      appState.setCurrentBook(
                          book, appState.playbackPositions[book.id] ?? 0);
                      // Optionally switch to Player tab.
                      ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Ready to play! Go to Player tab.')));
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
