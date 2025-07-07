import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/app_state.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Library'),
      ),
      body: Consumer<AppState>(
        builder: (context, appState, child) {
          if (appState.library.isEmpty) {
            return const Center(
              child: Text('Your library is empty. Purchase audiobooks in the store!'),
            );
          }
          return ListView.builder(
            itemCount: appState.library.length,
            itemBuilder: (context, index) {
              final audiobook = appState.library[index];
              return ListTile(
                leading: Image.network(audiobook.coverUrl),
                title: Text(audiobook.title),
                subtitle: Text(audiobook.author),
                onTap: () {
                  appState.play(audiobook);
                  appState.setSelectedIndex(2);
                },
              );
            },
          );
        },
      ),
    );
  }
}
