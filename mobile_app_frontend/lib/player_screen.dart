import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// PlayerScreen - Displays the currently selected audiobook.
/// This screen now shows only the audiobook details, without audio playback functionality.
class PlayerScreen extends StatelessWidget {
  const PlayerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final Audiobook? currentBook = appState.currentBook;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Audiobook Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: currentBook == null
              ? const Text("No audiobook selected.", style: TextStyle(fontSize: 18))
              : _buildBookDetails(context, currentBook),
        ),
      ),
    );
  }

  Widget _buildBookDetails(BuildContext context, Audiobook book) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Cover image and title
        if (book.coverUrl.isNotEmpty)
          Container(
            height: 180,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                book.coverUrl,
                fit: BoxFit.cover,
                width: 150,
                height: 180,
                errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported)),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          book.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          book.author,
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
        ),
        const SizedBox(height: 20),
        const Text(
          "Audio playback is currently disabled.",
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ],
    );
  }
}
