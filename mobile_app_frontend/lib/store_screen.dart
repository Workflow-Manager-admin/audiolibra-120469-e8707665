import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/audiobook.dart';
import 'app_state.dart';

/// The store screen for browsing audiobooks and purchasing.
/// Displays books as a grid, with search functionality.
class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  // Responsive grid crossAxisCount for different devices
  int getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 700) {
      return 4;
    } else if (width > 400) {
      return 2;
    } else {
      return 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Use Provider for app state and audiobooks
    final appState = context.watch<AppState>();
    final List<Audiobook> storeBooks = appState.storeAudiobooks;
    final Set<String> ownedIds = appState.ownedAudiobookIds;

    // Search filter controller in upper area
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
      ),
      body: _StoreScreenBody(
        storeBooks: storeBooks,
        ownedIds: ownedIds,
        appState: appState,
        crossAxisCount: getCrossAxisCount(context),
      ),
    );
  }
}

/// The main body containing search and grid
class _StoreScreenBody extends StatefulWidget {
  final List<Audiobook> storeBooks;
  final Set<String> ownedIds;
  final AppState appState;
  final int crossAxisCount;

  const _StoreScreenBody({
    required this.storeBooks,
    required this.ownedIds,
    required this.appState,
    required this.crossAxisCount,
    Key? key,
  }) : super(key: key);

  @override
  State<_StoreScreenBody> createState() => _StoreScreenBodyState();
}

class _StoreScreenBodyState extends State<_StoreScreenBody> {
  String _search = '';

  List<Audiobook> get filteredBooks {
    if (_search.isEmpty) return widget.storeBooks;
    return widget.storeBooks
        .where((b) =>
            b.title.toLowerCase().contains(_search.toLowerCase()) ||
            b.author.toLowerCase().contains(_search.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          TextField(
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search by title or author',
              isDense: true,
            ),
            onChanged: (v) => setState(() => _search = v),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: GridView.builder(
              itemCount: filteredBooks.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: widget.crossAxisCount,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.62,
              ),
              itemBuilder: (ctx, idx) {
                final book = filteredBooks[idx];
                final bool owned = widget.ownedIds.contains(book.id);

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _CoverImageWidget(url: book.coverUrl ?? ''),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                book.title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                book.author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.caption,
                              ),
                              const SizedBox(height: 6),
                              owned
                                  ? const Chip(
                                      label: Text('Owned'),
                                      backgroundColor: Color(0xFFD9F3DB),
                                      labelStyle: TextStyle(
                                          color: Color(0xFF387D47),
                                          fontWeight: FontWeight.bold),
                                    )
                                  : SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        onPressed: () async {
                                          final purchased =
                                              await _simulateStripePurchase(
                                                  context, book);
                                          if (purchased && context.mounted) {
                                            widget.appState.addToLibrary(book);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(const SnackBar(
                                                    content: Text(
                                                        "Purchase succeeded! Book added to your library.")));
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6)),
                                        child: Text(
                                            '\$${book.price?.toStringAsFixed(2) ?? 'Buy'} Buy'),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Simulates a Stripe payment flow (demo).
  Future<bool> _simulateStripePurchase(BuildContext context, Audiobook book) async {
    // PUBLIC_INTERFACE: Replace with Stripe API integration.
    return await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: const Text('Demo Purchase'),
                  content: Text('Pay \$${book.price?.toStringAsFixed(2) ?? ''} (Stripe integration placeholder)'),
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
                )) ??
        false;
  }
}

/// Cover image widget with loading/error handling.
class _CoverImageWidget extends StatelessWidget {
  final String url;

  const _CoverImageWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url.isEmpty) {
      return Container(
        color: Colors.grey.shade200,
        child: const Icon(Icons.library_music, size: 46),
      );
    }
    return Image.network(
      url,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          color: Colors.grey.shade200,
          child: const Center(child: CircularProgressIndicator()),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        return Container(
          color: Colors.grey.shade300,
          child: const Center(child: Icon(Icons.broken_image, size: 28)),
        );
      },
    );
  }
}
