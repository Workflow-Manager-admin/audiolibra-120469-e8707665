import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final library = appState.library;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Library'),
      ),
      body: library.isEmpty
          ? const Center(child: Text('No audiobooks in your library.'))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: library.length,
              itemBuilder: (context, index) {
                final book = library[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset(book.coverAsset, width: 56, height: 56, fit: BoxFit.cover),
                    title: Text(book.title),
                    subtitle: Text('By ${book.author}'),
                    onTap: () => appState.setCurrentBook(book),
                  ),
                );
              },
            ),
    );
  }
}
