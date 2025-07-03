import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'dart:developer' as developer;

/// PlayerScreen - Audio playback screen for the audiobook app.
/// Shows audiobook player, logs errors and audio source URL for troubleshooting.
/// Add this screen to visually debug attempted playback URLs and error messages.
class PlayerScreen extends StatefulWidget {
  final String audiobookTitle;
  final String audioUrl;

  const PlayerScreen({
    super.key,
    required this.audiobookTitle,
    required this.audioUrl,
  });

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

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _initializePlayer();
  }

  // Initialize player and log the URL and any errors
  Future<void> _initializePlayer() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });
    try {
      developer.log("[PlayerScreen] Attempting setUrl: '${widget.audioUrl}'", name: "PlayerScreen");
      if (widget.audioUrl.isEmpty) {
        developer.log("[PlayerScreen] ERROR: Audio URL is empty.", name: "PlayerScreen");
      }
      await _player.setUrl(widget.audioUrl);
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
      return Center(child: Text(_error!, style: TextStyle(color: Colors.red)));
    }
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          "",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
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
          children: [
            IconButton(
              icon: const Icon(Icons.replay_10),
              onPressed: () =>
                  _player.seek(_position - const Duration(seconds: 10)),
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
              onPressed: () =>
                  _player.seek(_position + const Duration(seconds: 10)),
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
        title: Text("Audiobook Player"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: _buildPlayer(),
      ),
    );
  }
}
