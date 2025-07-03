import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// PlayerScreen - Audio playback screen for the audiobook app.
/// Shows audiobook player, logs errors and audio source URL for troubleshooting.
/// Now displays audiobook cover image and title above the progress bar.
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isLoading = true;
  String? _error;

  Audiobook? _currentBook;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    // Delay player initialization until currentBook is set in didChangeDependencies
  }

  // Retrieve the currentBook from AppState and initialize the player if needed
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context);
    if (appState.currentBook != null && _currentBook != appState.currentBook) {
      _currentBook = appState.currentBook;
      _initializePlayer(_currentBook!.audioUrl);
    }
  }

  // Initialize player and log the URL and any errors
  Future<void> _initializePlayer(String audioUrl) async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      developer.log("[PlayerScreen] Attempting setUrl: '$audioUrl'", name: "PlayerScreen");
      if (audioUrl.isEmpty) {
        developer.log("[PlayerScreen] ERROR: Audio URL is empty.", name: "PlayerScreen");
      }
      await _player.setUrl(audioUrl);
      _duration = _player.duration ?? Duration.zero;
      _player.positionStream.listen((position) {
        setState(() {
          _position = position;
        });
      });
      setState(() {
        _isLoading = false;
      });
      developer.log("[PlayerScreen] Audio loaded successfully.", name: "PlayerScreen");
    } catch (e) {
      developer.log("[PlayerScreen] Source error: $e", name: "PlayerScreen", error: e);
      setState(() {
        _error = 'Source error: $e';
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  Widget _buildPlayer() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(child: Text(_error!, style: const TextStyle(color: Colors.red)));
    }
    if (_currentBook == null) {
      return const Center(child: Text("No audiobook selected.", style: TextStyle(fontSize: 18)));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        // Cover image and title
        if (_currentBook!.coverUrl.isNotEmpty)
          Container(
            height: 180,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                _currentBook!.coverUrl,
                fit: BoxFit.cover,
                width: 150,
                height: 180,
                errorBuilder: (context, error, stackTrace) =>
                    Container(
                      color: Colors.grey[200], 
                      child: const Icon(Icons.image_not_supported)
                    ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        Text(
          _currentBook!.title,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          _currentBook!.author,
          style: const TextStyle(fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black54),
        ),
        const SizedBox(height: 10),
        Slider(
          min: 0,
          max: _duration.inMilliseconds.toDouble(),
          value: _position.inMilliseconds.clamp(0, _duration.inMilliseconds).toDouble(),
          onChanged: (value) {
            _player.seek(Duration(milliseconds: value.round()));
          },
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () => _player.seek(_position - const Duration(seconds: 10)),
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
                _isPlaying ? _player.play() : _player.pause();
              },
            ),
            IconButton(
              icon: const Icon(Icons.forward_10),
              onPressed: () => _player.seek(_position + const Duration(seconds: 10)),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Audiobook Player"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: _buildPlayer(),
        ),
      ),
    );
  }
}
