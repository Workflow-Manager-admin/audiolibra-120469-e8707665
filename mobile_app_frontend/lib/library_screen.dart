import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/app_state.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';

/// The user's audiobook library (purchased books).
class LibraryScreen extends StatefulWidget {
  final AppState appState;
  const LibraryScreen({required this.appState, super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    final books = widget.appState.purchasedBooks;
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
                  return ListTile(
                    leading: AspectRatio(
                      aspectRatio: 1/1.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(book.coverUrl, fit: BoxFit.cover),
                      ),
                    ),
                    title: Text(book.title, 
                        style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16
                        )),
                    subtitle: Text(book.author),
                    trailing: Icon(Icons.play_circle, color: Theme.of(context).colorScheme.secondary),
                    onTap: () {
                      widget.appState.setCurrentBook(book, 
                        widget.appState.playbackPositions[book.id] ?? 0
                      );
                      // Optionally switch to Player tab.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ready to play! Go to Player tab.'))
                      );
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
