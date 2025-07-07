import 'package:flutter/material.dart';
import 'models/audiobook.dart';

/// StoreScreen displays audiobooks for sale in a grid layout with cover, title, author, and buy button.
/// Displays "1984", "Moby Dick", "Pride and Prejudice", and "The Great Gatsby".
class StoreScreen extends StatelessWidget {
  // PUBLIC_INTERFACE
  /// All featured audiobooks to display in the store grid.
  final List<Audiobook> allBooks = [
    Audiobook(
      id: '1984',
      title: "1984",
      author: "George Orwell",
      coverUrl: "https://covers.openlibrary.org/b/id/7222246-L.jpg",
      sampleUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
      price: 11.99,
      description: "A dystopian novel about a totalitarian regime.",
      durationSeconds: 40132,
    ),
    Audiobook(
      id: 'moby_dick',
      title: "Moby Dick",
      author: "Herman Melville",
      coverUrl: "https://covers.openlibrary.org/b/id/5552197-L.jpg",
      sampleUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
      audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
      price: 10.99,
      description: "A sea adventure and whaling tale.",
      durationSeconds: 79224,
    ),
    Audiobook(
      id: 'pride_prejudice',
      title: "Pride and Prejudice",
      author: "Jane Austen",
      coverUrl: "https://covers.openlibrary.org/b/id/8084088-L.jpg",
      sampleUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
      audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3",
      price: 8.99,
      description: "A classic romance novel.",
      durationSeconds: 52052,
    ),
    Audiobook(
      id: 'gatsby',
      title: "The Great Gatsby",
      author: "F. Scott Fitzgerald",
      coverUrl: "https://covers.openlibrary.org/b/id/7222161-L.jpg",
      sampleUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
      audioUrl: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
      price: 9.99,
      description: "A story of the Jazz Age in the Roaring Twenties.",
      durationSeconds: 28680,
    ),
  ];

  StoreScreen({super.key});

  // PUBLIC_INTERFACE
  /// Builds the store screen grid view UI.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          itemCount: allBooks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.63,
            crossAxisSpacing: 16,
            mainAxisSpacing: 18,
          ),
          itemBuilder: (context, index) {
            final book = allBooks[index];
            return GestureDetector(
              onTap: () {
                _showAudiobookDialog(context, book);
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(9),
                        child: Image.network(
                          book.coverUrl,
                          height: 132,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) =>
                              Container(height: 132, color: Colors.grey[250], child: const Icon(Icons.broken_image, size: 44)),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        book.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        book.author,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, color: Theme.of(context).colorScheme.primary),
                          const SizedBox(width: 5),
                          Text("Buy", style: TextStyle(color: Theme.of(context).colorScheme.primary)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // PUBLIC_INTERFACE
  /// Displays a dialog with audiobook details.
  void _showAudiobookDialog(BuildContext context, Audiobook audiobook) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      audiobook.coverUrl,
                      height: 230,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 72),
                    ),
                  ),
                  const SizedBox(height: 18),
                  Text(
                    audiobook.title,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'By ${audiobook.author}',
                    style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.deepPurple),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    audiobook.description,
                    style: const TextStyle(fontSize: 15),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 19),
                  // Mock purchase button for demo
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Purchase simulated. Book added to your library.")),
                      );
                    },
                    child: Text('Buy for \$${audiobook.price.toStringAsFixed(2)}'),
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: Colors.grey.shade200,
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
