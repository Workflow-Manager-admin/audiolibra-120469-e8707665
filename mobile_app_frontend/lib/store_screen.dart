import 'package:flutter/material.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// StoreScreen displays all audiobooks available in the store as a responsive grid.
/// Each book is shown as a card with its cover, title, and price.
// PUBLIC_INTERFACE
import 'package:provider/provider.dart';

class StoreScreen extends StatelessWidget {
  /// StoreScreen displays all audiobooks available in the store as a responsive grid.
  /// AppState is accessed via Provider.
  // PUBLIC_INTERFACE
  const StoreScreen({super.key});

  // Card for a single audiobook (cover image, title, price)
  Widget _buildBookCard(BuildContext context, Audiobook book) {
    return Card(
      elevation: 3,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Cover image
          AspectRatio(
            aspectRatio: 4 / 5,
            child: book.coverUrl.isNotEmpty
                ? Image.network(
                    book.coverUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: Colors.grey[200],
                      child: const Icon(Icons.image, color: Colors.grey, size: 40),
                    ),
                  )
                : Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image, color: Colors.grey, size: 40),
                  ),
          ),
          // Book info
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  // Prices in the model are doubles (not cents), so show as fixed with 2 decimals
                  '\$${book.price.toStringAsFixed(2)}',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Responsive grid: adjusts column count based on width.
  int _calculateGridCount(double width) {
    if (width >= 900) return 4;
    if (width >= 600) return 3;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final books = appState.storeAudiobooks;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        elevation: 0,
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = _calculateGridCount(constraints.maxWidth);
            return GridView.builder(
              itemCount: books.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (context, index) {
                final book = books[index];
                return _buildBookCard(context, book);
              },
            );
          },
        ),
      ),
    );
  }
}
