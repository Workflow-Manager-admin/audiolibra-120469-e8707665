import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

class PlayerScreen extends StatelessWidget {
  const PlayerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    Audiobook? book = appState.currentBook;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Player'),
      ),
      body: book == null
          ? const Center(child: Text('Select a book from your library'))
          : _PlayerUI(book: book),
    );
  }
}

class _PlayerUI extends StatefulWidget {
  final Audiobook book;
  const _PlayerUI({required this.book});

  @override
  State<_PlayerUI> createState() => _PlayerUIState();
}

class _PlayerUIState extends State<_PlayerUI> {
  double progress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(widget.book.coverAsset, width: 150, height: 150),
          const SizedBox(height: 24),
          Text(widget.book.title, style: Theme.of(context).textTheme.titleLarge),
          Text(widget.book.author, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 36),
          Slider(
            min: 0,
            max: 1,
            value: progress,
            onChanged: (v) => setState(() => progress = v),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.replay_10),
                onPressed: () {},
                tooltip: 'Rewind 15 seconds',
              ),
              IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 48,
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(Icons.forward_10),
                onPressed: () {},
                tooltip: 'Skip 15 seconds',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
