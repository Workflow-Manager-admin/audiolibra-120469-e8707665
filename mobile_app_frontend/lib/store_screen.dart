import 'package:flutter/material.dart';
import 'models/audiobook.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';

class StoreScreen extends StatelessWidget {
  const StoreScreen({Key? key}) : super(key: key);

  static final List<Audiobook> demoBooks = [
    Audiobook(id: '1', title: 'Moby Dick', author: 'Herman Melville', coverAsset: 'assets/moby_dick_cover.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    var state = Provider.of<AppState>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Audiobook Store'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: demoBooks.length,
        itemBuilder: (context, index) {
          final book = demoBooks[index];
          return Card(
            child: ListTile(
              leading: Image.asset(book.coverAsset, width: 56, height: 56, fit: BoxFit.cover),
              title: Text(book.title),
              subtitle: Text('By ${book.author}'),
              trailing: ElevatedButton(
                onPressed: () {
                  state.addToLibrary(book);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${book.title} added to your library!')),
                  );
                },
                child: const Text('Buy'),
              ),
            ),
          );
        },
      ),
    );
  }
}
