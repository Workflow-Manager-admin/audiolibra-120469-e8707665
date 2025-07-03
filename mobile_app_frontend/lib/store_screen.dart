import 'package:flutter/material.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';
import 'package:mobile_app_frontend/app_state.dart';

// Dummy store catalog for the demo.
final List<Audiobook> kStoreBooks = [
  Audiobook(
    id: 'book1',
    title: 'The Art of Flutter',
    author: 'Jane Smith',
    coverUrl: 'https://covers.openlibrary.org/b/id/8228691-L.jpg',
    price: 14.99,
    sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  ),
  Audiobook(
    id: 'book2',
    title: 'Minimalism in Life',
    author: 'John Doe',
    coverUrl: 'https://covers.openlibrary.org/b/id/5546156-L.jpg',
    price: 19.99,
    sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
  ),
  Audiobook(
    id: 'book3',
    title: 'Clean Code: A Handbook',
    author: 'Robert Martin',
    coverUrl: 'https://covers.openlibrary.org/b/id/10544435-L.jpg',
    price: 17.99,
    sampleUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
    audioUrl: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
  ),
];

/// The store screen for browsing audiobooks and purchasing via Stripe.
class StoreScreen extends StatefulWidget {
  final AppState appState;
  const StoreScreen({required this.appState, super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  String _search = '';

  List<Audiobook> get filtered =>
      _search.isEmpty
          ? kStoreBooks
          : kStoreBooks
              .where((b) =>
                  b.title.toLowerCase().contains(_search.toLowerCase()) ||
                  b.author.toLowerCase().contains(_search.toLowerCase()))
              .toList();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Audiobook Store',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 16),
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by title or author',
              isDense: true,
            ),
            onChanged: (v) => setState(() => _search = v),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const Divider(height: 24),
              itemBuilder: (_, idx) {
                final book = filtered[idx];
                final purchased = widget.appState.purchasedBooks
                    .any((b) => b.id == book.id);
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: AspectRatio(
                    aspectRatio: 1/1.4,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(book.coverUrl, fit: BoxFit.cover),
                    ),
                  ),
                  title: Text(book.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 16)),
                  subtitle: Text(book.author),
                  trailing: purchased
                    ? const Chip(label: Text('Owned'))
                    : ElevatedButton(
                        child: Text('\$${book.price.toStringAsFixed(2)} Buy'),
                        onPressed: () async {
                          final purchased = await _simulateStripePurchase(context, book);
                          if (purchased && context.mounted) {
                            widget.appState.addToLibrary(book);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Purchase succeeded! Book added to your library."))
                            );
                          }
                        },
                      ),
                  onTap: () {},
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Simulates a Stripe payment flow.
  Future<bool> _simulateStripePurchase(BuildContext context, Audiobook book) async {
    // PUBLIC_INTERFACE: Replace with actual Stripe API integration.
    return await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Demo Purchase'),
          content: Text('Pay \$${book.price.toStringAsFixed(2)} (Stripe integration placeholder)'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Purchase'),
            ),
          ],
        )) ?? false;
  }
}
