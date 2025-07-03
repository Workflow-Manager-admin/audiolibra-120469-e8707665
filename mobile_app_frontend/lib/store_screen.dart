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

  // PUBLIC_INTERFACE
  void _showAudiobookDialog(BuildContext context, Audiobook audiobook, bool owned) {
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
                  if (audiobook.coverUrl != null && audiobook.coverUrl!.isNotEmpty)
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        audiobook.coverUrl!,
                        height: 220,
                        fit: BoxFit.cover,
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
                    audiobook.description ?? '',
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
                        // Immediate mock purchase: add to library and show snackbar
                        widget.appState.addToLibrary(audiobook);
                        Navigator.of(dialogContext).pop();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Purchase succeeded! Book added to your library."),
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
                      child: Text(
                        '\\$${audiobook.price?.toStringAsFixed(2) ?? 'Buy'} Buy'
                      ),
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
                    onTap: () {
                      _showAudiobookDialog(context, book, owned);
                    },
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
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              Text(
                                book.author,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
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
                                          // Immediate mock purchase: add to library and show snackbar
                                          widget.appState.addToLibrary(book);
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              content: Text(
                                                  "Purchase succeeded! Book added to your library."),
                                            ),
                                          );
                                        },
                                        style: ElevatedButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 6)),
                                        child: Text(
                                            '\\$${book.price?.toStringAsFixed(2) ?? 'Buy'} Buy'),
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
  // The Stripe/dialog mock is fully removed.
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
