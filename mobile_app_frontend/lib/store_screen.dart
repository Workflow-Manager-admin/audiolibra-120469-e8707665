import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/app_state.dart';
import 'package:provider/provider.dart';
import 'models/audiobook.dart';

/// The Store screen for browsing audiobooks and purchasing.
/// Only displays the specified 8 titles for this task.
class StoreScreen extends StatelessWidget {
  const StoreScreen({super.key});

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    // Use Provider for app state and audiobooks
    final appState = context.watch<AppState>();
    final List<Audiobook> storeBooks = appState.storeAudiobooks;
    final Set<String> ownedIds = appState.ownedAudiobookIds;

    // Only the following titles should be visible, in this order:
    const titlesToShow = [
      'Little Women',
      'Jane Eyre',
      'Sherlock Holmes',
      'Frankenstein',
      'To Kill a Mockingbird',
      'War and Peace',
      'The Odyssey',
      'The Grapes of Wrath',
    ];

    // Filter and maintain order
    final filteredBooks = [
      for (final title in titlesToShow)
        ...storeBooks.where((ab) => ab.title == title)
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView.builder(
          itemCount: filteredBooks.length,
          itemBuilder: (ctx, idx) {
            final book = filteredBooks[idx];
            final bool owned = ownedIds.contains(book.id);
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              elevation: 4,
              child: ListTile(
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: book.coverUrl.isNotEmpty
                      ? Image.network(
                          book.coverUrl,
                          width: 56,
                          height: 56,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image),
                        )
                      : const Icon(Icons.audiotrack),
                ),
                title: Text(
                  book.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  book.author,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                trailing: owned
                    ? const Chip(
                        label: Text('Owned'),
                        backgroundColor: Color(0xFFD9F3DB),
                        labelStyle: TextStyle(
                            color: Color(0xFF387D47), fontWeight: FontWeight.bold),
                      )
                    : ElevatedButton(
                        onPressed: () async {
                          appState.addToLibrary(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  "Purchase succeeded! Book added to your library."),
                            ),
                          );
                        },
                        child:
                            Text('\$${book.price.toStringAsFixed(2)} Buy'),
                      ),
                onTap: () => _showAudiobookDialog(context, book, owned, appState),
              ),
            );
          },
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  void _showAudiobookDialog(
      BuildContext context, Audiobook audiobook, bool owned, AppState appState) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (audiobook.coverUrl.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        audiobook.coverUrl,
                        height: 220,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    )
                  else
                    Container(
                      height: 150,
                      color: Colors.grey.shade200,
                      child: const Icon(Icons.library_music, size: 70),
                    ),
                  const SizedBox(height: 20),
                  Text(
                    audiobook.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${audiobook.author}',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Colors.deepPurple,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    audiobook.description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 16),
                  if (owned)
                    const Chip(
                      label: Text('Owned'),
                      backgroundColor: Color(0xFFD9F3DB),
                      labelStyle: TextStyle(
                          color: Color(0xFF387D47), fontWeight: FontWeight.bold),
                    ),
                  if (!owned)
                    ElevatedButton(
                      onPressed: () async {
                        appState.addToLibrary(audiobook);
                        Navigator.of(dialogContext).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "Purchase succeeded! Book added to your library."),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          Text('\$${audiobook.price.toStringAsFixed(2)} Buy'),
                    ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey.shade200,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
