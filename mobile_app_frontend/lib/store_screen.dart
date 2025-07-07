import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

// PUBLIC_INTERFACE
class StoreScreen extends StatelessWidget {
  /// StoreScreen displays all audiobooks available for sale in a grid of cards.
  /// Each card shows the cover image (coverUrl), title, and price.
  /// The book list is retrieved from AppState.storeAudiobooks.

  const StoreScreen({super.key});

  // PUBLIC_INTERFACE
  @override
  Widget build(BuildContext context) {
    final audiobooks = context.watch<AppState>().storeAudiobooks;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 1,
      ),
      body: audiobooks.isEmpty
          ? const Center(child: Text('No audiobooks available in the store.'))
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.builder(
                itemCount: audiobooks.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 cards per row
                  childAspectRatio: 0.70, // Card aspect ratio
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemBuilder: (context, index) {
                  final audiobook = audiobooks[index];
                  return StoreBookCard(audiobook: audiobook);
                },
              ),
            ),
    );
  }
}

// PUBLIC_INTERFACE
class StoreBookCard extends StatelessWidget {
  /// Card widget representing an audiobook in the store grid.
  /// Shows its coverUrl as Image.network, its title, and its price.

  final Audiobook audiobook;

  const StoreBookCard({super.key, required this.audiobook});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: () {
          // TODO: Show book details or purchase dialog
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Cover Image
              AspectRatio(
                aspectRatio: 3 / 4,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: audiobook.coverUrl.isNotEmpty
                      ? Image.network(
                          audiobook.coverUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => Container(
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: const Icon(Icons.library_music, size: 42, color: Colors.grey),
                          ),
                        )
                      : Container(
                          color: Colors.grey[300],
                          alignment: Alignment.center,
                          child: const Icon(Icons.library_music, size: 42, color: Colors.grey),
                        ),
                ),
              ),
              const SizedBox(height: 12),
              // Title
              Text(
                audiobook.title,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              // Price
              Text(
                _formatPrice(audiobook.price),
                style: theme.textTheme.titleSmall?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  static String _formatPrice(double price) {
    /// Returns price formatted as a string with a currency sign.
    return "\$${price.toStringAsFixed(2)}";
  }
}
