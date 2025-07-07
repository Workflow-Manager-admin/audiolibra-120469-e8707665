import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// The StoreScreen displays all available audiobooks in a responsive grid format,
/// pulling live data from AppState._storeAudiobooks. Each card shows cover image,
/// title, and price, and gracefully handles layout on various screen sizes.
///
class StoreScreen extends StatelessWidget {
  // PUBLIC_INTERFACE
  const StoreScreen({super.key});

  /// Determine item cross axis count based on width for responsiveness.
  int _getCrossAxisCount(double width) {
    if (width >= 1200) return 5;
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final storeAudiobooks = context.watch<AppState>().storeAudiobooks; // Use only the live AppState list

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = _getCrossAxisCount(constraints.maxWidth);
        return Scaffold(
          appBar: AppBar(
            title: const Text("Audiobook Store"),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(12.0),
            child: storeAudiobooks.isEmpty
                ? const Center(child: Text('No audiobooks available'))
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.64,
                    ),
                    itemCount: storeAudiobooks.length,
                    itemBuilder: (context, index) {
                      final Audiobook book = storeAudiobooks[index];
                      return _AudiobookCard(audiobook: book);
                    },
                  ),
          ),
        );
      },
    );
  }
}

/// A card widget to display an audiobook's cover, title, and price.
class _AudiobookCard extends StatelessWidget {
  final Audiobook audiobook;

  const _AudiobookCard({required this.audiobook});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // TODO: Implement purchase or navigation to details if needed.
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: audiobook.coverUrl.isNotEmpty
                  ? Image.network(
                      audiobook.coverUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: Colors.grey[300],
                        child: Icon(Icons.image_not_supported, color: Colors.grey[600], size: 48),
                      ),
                    )
                  : Container(
                      color: Colors.grey[300],
                      child: Icon(Icons.image, color: Colors.grey[600], size: 48),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              child: Text(
                audiobook.title,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 10),
              child: Text(
                _formatPrice(audiobook.price),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.secondary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static String _formatPrice(double price) {
    // PUBLIC_INTERFACE
    /// Returns formatted price string with currency symbol.
    return "\$${price.toStringAsFixed(2)}";
  }
}
