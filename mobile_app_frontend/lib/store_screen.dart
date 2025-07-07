import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app_state.dart';
import 'models/audiobook.dart';

/// StoreScreen
///
/// Displays all store audiobooks from AppState._storeAudiobooks as a responsive grid of cards.
/// Each card shows the book cover (Image.network), title, and price.
class StoreScreen extends StatelessWidget {
  // PUBLIC_INTERFACE
  const StoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the AppState and the store audiobooks
    final appState = context.watch<AppState>();
    final List<Audiobook> books = appState.storeAudiobooks;

    // Responsive column count based on screen width
    int calculateCrossAxisCount(BuildContext context) {
      final width = MediaQuery.of(context).size.width;
      if (width >= 1000) return 5;
      if (width >= 700) return 4;
      if (width >= 500) return 3;
      return 2;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Store'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: books.isEmpty
          ? const Center(child: Text("No audiobooks available in store."))
          : LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = calculateCrossAxisCount(context);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GridView.builder(
                    itemCount: books.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 0.60,
                    ),
                    itemBuilder: (context, index) {
                      final book = books[index];
                      return StoreBookCard(book: book);
                    },
                  ),
                );
              },
            ),
    );
  }
}

/// Card widget for each Audiobook in the grid
class StoreBookCard extends StatelessWidget {
  final Audiobook book;

  // PUBLIC_INTERFACE
  const StoreBookCard({Key? key, required this.book}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Styling parameters (can be adjusted for theme consistency)
    const borderRadius = BorderRadius.all(Radius.circular(12));
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: borderRadius,
      ),
      child: InkWell(
        borderRadius: borderRadius,
        onTap: () {
          // Optionally, tap to show details or start purchase flow
          // Navigator.push(...);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Book cover
            Expanded(
              flex: 7,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: book.coverUrl != null && book.coverUrl.isNotEmpty
                    ? Image.network(
                        book.coverUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, err, stack) => const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
                      )
                    : Container(
                        color: Colors.grey[200],
                        alignment: Alignment.center,
                        child: const Icon(Icons.audiotrack, size: 48, color: Colors.grey),
                      ),
              ),
            ),
            // Title and price
            Expanded(
              flex: 3,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        book.price != null ? "\$${book.price!.toStringAsFixed(2)}" : "No price",
                        style: Theme.of(context).textTheme.subtitle2?.copyWith(
                              color: Theme.of(context).colorScheme.secondary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
