import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// StoreScreen displays all available audiobooks for purchase as a responsive grid.
/// Each audiobook is shown as a card with its cover image, title, and price.
/// The audiobooks are accessed reactively from AppState._storeAudiobooks via Provider.
/// This widget listens to AppState and updates the grid in real time as the audiobook list changes.
class StoreScreen extends StatelessWidget {
  // PUBLIC_INTERFACE
  const StoreScreen({super.key});

  /// Builds a card for a single audiobook to be displayed in the grid.
  Widget _buildBookCard(BuildContext context, Audiobook audiobook) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        onTap: () {
          // TODO: Implement audiobook details or purchase navigation if needed
        },
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12.0)),
                child: (audiobook.coverUrl.isNotEmpty)
                    ? Image.network(
                        audiobook.coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: const Center(
                              child: Icon(Icons.broken_image, size: 32, color: Colors.grey),
                            ),
                          );
                        },
                      )
                    : Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.audiotrack, size: 32, color: Colors.grey),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
              child: Text(
                audiobook.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 8.0),
              child: Text(
                '\$${audiobook.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Listen to AppState for updates to the store audiobooks list.
    final storeAudiobooks = context.watch<AppState>().storeAudiobooks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: storeAudiobooks.isEmpty
            ? const Center(
                child: Text(
                  'No audiobooks available for sale.',
                  style: TextStyle(fontSize: 16),
                ),
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  // Simple logic for responsiveness (2- or 3-column grid)
                  int crossAxisCount = constraints.maxWidth > 600
                      ? 3
                      : 2;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.68,
                    ),
                    itemCount: storeAudiobooks.length,
                    itemBuilder: (context, idx) {
                      final audiobook = storeAudiobooks[idx];
                      return _buildBookCard(context, audiobook);
                    },
                  );
                },
              ),
      ),
    );
  }
}
