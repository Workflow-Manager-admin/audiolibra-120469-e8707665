import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// StoreScreen displays all available audiobooks for purchase as a responsive grid.
/// Each audiobook is shown as a card with its cover image, title, price and a short description.
/// Tapping a card opens a modern dialog with more information and a "Buy" button.
/// The audiobooks are accessed reactively from AppState._storeAudiobooks via Provider.
class StoreScreen extends StatelessWidget {
  // PUBLIC_INTERFACE
  const StoreScreen({super.key});

  /// Builds a modern card for a single audiobook, with tap to see details and buy.
  Widget _buildBookCard(BuildContext context, Audiobook audiobook) {
    return Card(
      margin: const EdgeInsets.all(10.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        onTap: () {
          _showDetailDialog(context, audiobook);
        },
        borderRadius: BorderRadius.circular(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Cover image
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
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
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.audiotrack, size: 36, color: Colors.grey),
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
              child: Text(
                audiobook.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                '\$${audiobook.price.toStringAsFixed(2)}',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(12.0, 4.0, 12.0, 6.0),
              child: Text(
                audiobook.description,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[700],
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  /// Shows a dialog with details and a Buy button for the audiobook.
  void _showDetailDialog(BuildContext context, Audiobook audiobook) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (ctx) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          insetPadding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (audiobook.coverUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      audiobook.coverUrl,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.broken_image, size: 42, color: Colors.grey),
                        );
                      },
                    ),
                  )
                else
                  Container(
                    height: 180,
                    color: Colors.grey[200],
                    child: const Icon(Icons.audiotrack, size: 38, color: Colors.grey),
                  ),
                const SizedBox(height: 12),
                Text(
                  audiobook.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 20,
                      ),
                  textAlign: TextAlign.left,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  'by ${audiobook.author}',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontStyle: FontStyle.italic,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Text(
                  audiobook.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 14),
                Text(
                  '\$${audiobook.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    elevation: 1,
                  ),
                  icon: const Icon(Icons.shopping_cart),
                  label: const Text('Buy', style: TextStyle(fontSize: 17)),
                  onPressed: () {
                    // TODO: Add purchase flow here
                    Navigator.of(ctx).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Purchase flow not yet implemented.')),
                    );
                  },
                )
              ],
            ),
          ),
        );
      },
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
                  // Responsive: 2 or 3-column grid
                  int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;

                  return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      childAspectRatio: 0.66,
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
