import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:developer' as developer;
import 'package:provider/provider.dart';
import 'app_state.dart';
import 'models/audiobook.dart';

/// PlayerScreen - Audio playback screen for the audiobook app.
/// Shows realistic progress bar (data-driven duration) and time labels.
class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _player;
  bool _isPlaying = false;
  Duration _audioDuration = Duration.zero;
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final appState = Provider.of<AppState>(context);
    if (appState.currentBook != null && _currentBook != appState.currentBook) {
      _currentBook = appState.currentBook;
      _initializePlayer(_currentBook!.audioUrl);
    }
  }

  Future<void> _initializePlayer(String audioUrl) async {
    setState(() {
      _isLoading = true;
      _error = null;
      _position = Duration.zero;
      _audioDuration = Duration.zero;
    });
    try {
      developer.log("[PlayerScreen] setUrl: '$audioUrl'", name: "PlayerScreen");
      if (audioUrl.isEmpty) {
        setState(() {
          _error = "Error: Audio URL is empty.";
          _isLoading = false;
        });
        return;
      }
      if (!(audioUrl.startsWith('http://') || audioUrl.startsWith('https://'))) {
        setState(() {
          _error = "Error: Invalid audio URL.";
          _isLoading = false;
        });
        return;
      }
      await _player.setUrl(audioUrl);
      _audioDuration = _player.duration ?? Duration.zero;
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

  // PUBLIC_INTERFACE
  String _formatDuration(Duration d) {
    final h = d.inHours.toString().padLeft(2, '0');
    final m = (d.inMinutes % 60).toString().padLeft(2, '0');
    final s = (d.inSeconds % 60).toString().padLeft(2, '0');
    return "$h:$m:$s";
  }

  // Returns the total duration to be shown for this audiobook:
  // Prefer model's durationSeconds; fallback to detected file duration if model not set.
  int? _getAudiobookDurationSeconds() {
    if (_currentBook?.durationSeconds != null &&
        _currentBook!.durationSeconds > 0) {
      return _currentBook!.durationSeconds;
    }
    if (_audioDuration.inSeconds > 0) {
      return _audioDuration.inSeconds;
    }
    return null;
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

    final int? totalSeconds = _getAudiobookDurationSeconds();
    final Duration totalDuration =
        totalSeconds != null ? Duration(seconds: totalSeconds) : Duration.zero;

    if (totalSeconds == null || totalSeconds <= 0) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentBook != null) ...[
              Text(
                _currentBook!.title,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(_currentBook!.author, style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 30),
            ],
            const Text(
              'Duration unknown. Unable to display progress bar.',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      );
    }

    final double sliderValue =
        _position.inSeconds.clamp(0, totalSeconds).toDouble();

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
                errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported)),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Slider(
                min: 0,
                max: totalSeconds.toDouble(),
                value: sliderValue,
                onChanged: (value) {
                  _player.seek(Duration(seconds: value.round()));
                },
                activeColor: Theme.of(context).primaryColor,
                inactiveColor: Theme.of(context).primaryColorLight,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _formatDuration(Duration(seconds: sliderValue.toInt())),
                    style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                  ),
                  Text(
                    _formatDuration(totalDuration),
                    style: const TextStyle(fontSize: 14, fontFamily: 'monospace'),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
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
