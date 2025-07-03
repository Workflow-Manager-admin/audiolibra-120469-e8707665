import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mobile_app_frontend/app_state.dart';
import 'package:mobile_app_frontend/models/audiobook.dart';

/// Player screen: display current book, playback progress, controls.
class PlayerScreen extends StatefulWidget {
  final AppState appState;
  const PlayerScreen({required this.appState, super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  StreamSubscription<Duration>? _positionSub;
  StreamSubscription<PlayerState>? _stateSub;

  Audiobook? _currentBook;
  bool _isLoaded = false;
  double _durationSec = 0;
  double _positionSec = 0;
  bool _playing = false;

  @override
  void initState() {
    super.initState();
    _currentBook = widget.appState.currentBook;
    _positionSec = widget.appState.currentPosition ?? 0;
    _loadBook();
  }

  @override
  void dispose() {
    _positionSub?.cancel();
    _stateSub?.cancel();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _loadBook() async {
    if (_currentBook == null) return;
    final url = widget.appState.purchasedBooks.any((b) => b.id == _currentBook!.id)
      ? _currentBook!.audioUrl
      : _currentBook!.sampleUrl;
    try {
      await _audioPlayer.setUrl(url);
      final duration = _audioPlayer.duration;
      if (!mounted) return;
      setState(() {
        _isLoaded = true;
        _durationSec = duration?.inSeconds.toDouble() ?? 0;
      });
      // Restore playback position if available
      if (_positionSec > 0 && _durationSec > 0) {
        await _audioPlayer.seek(Duration(seconds: _positionSec.round()));
      }
      _positionSub = _audioPlayer.positionStream.listen((pos) {
        if (mounted) {
          setState(() => _positionSec = pos.inSeconds.toDouble());
        }
        if (_currentBook != null) {
          widget.appState.updatePlaybackPosition(
              _currentBook!.id, _positionSec);
        }
      });
      _stateSub = _audioPlayer.playerStateStream.listen((state) {
        if (mounted) setState(() => _playing = state.playing);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isLoaded = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Failed to load audio: ${e.toString()}')),
      );
    }
  }

  void _play() async {
    if (!_playing) {
      await _audioPlayer.play();
    }
  }

  void _pause() async {
    if (_playing) {
      await _audioPlayer.pause();
    }
  }

  void _skipBy(int seconds) async {
    final newPos = (_positionSec + seconds).clamp(0, _durationSec);
    await _audioPlayer.seek(Duration(seconds: newPos.round()));
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isOwned = _currentBook != null &&
        widget.appState.purchasedBooks.any((b) => b.id == _currentBook!.id);

    return Padding(
      padding: const EdgeInsets.only(top: 42, left: 16, right: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Player', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 16),
          if (_currentBook == null)
            Expanded(
              child: Center(
                child: Text(
                  'Select an audiobook from your Library',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ),
            )
          else ...[
            Column(
              children: [
                SizedBox(
                  height: 240,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(_currentBook!.coverUrl,
                        fit: BoxFit.cover),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _currentBook!.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                Text(_currentBook!.author,
                    style: TextStyle(color: colorScheme.secondary)),
                const SizedBox(height: 12),
                Chip(
                  label: Text(isOwned ? 'Full Book' : 'Preview Only',
                    style: TextStyle(
                        color: isOwned ? colorScheme.tertiary : Colors.grey),
                  )
                ),
                const SizedBox(height: 24),
                _isLoaded
                    ? Column(
                        children: [
                          Slider(
                            min: 0,
                            max: _durationSec,
                            value: _positionSec.clamp(0, _durationSec),
                            onChanged: (val) async {
                              setState(() {
                                _positionSec = val;
                              });
                              await _audioPlayer.seek(
                                  Duration(seconds: val.round()));
                            },
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_formatTime(_positionSec)),
                              Text(_formatTime(_durationSec)),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                // Replacing replay_15 with rotate_left for 15-sec back
                                icon: Icon(Icons.rotate_left, color: colorScheme.secondary, size: 36),
                                iconSize: 36,
                                tooltip: 'Back 15 seconds',
                                onPressed: () => _skipBy(-15),
                              ),
                              SizedBox(width: 24),
                              ElevatedButton(
                                onPressed: _playing ? _pause : _play,
                                style: ElevatedButton.styleFrom(
                                  shape: CircleBorder(),
                                  padding: EdgeInsets.all(18),
                                  backgroundColor: colorScheme.secondary,
                                  elevation: 0,
                                ),
                                child: Icon(
                                  _playing ? Icons.pause : Icons.play_arrow,
                                  size: 36,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(width: 24),
                              IconButton(
                                // Replacing forward_15 with rotate_right for 15-sec forward
                                icon: Icon(Icons.rotate_right, color: colorScheme.secondary, size: 36),
                                iconSize: 36,
                                tooltip: 'Forward 15 seconds',
                                onPressed: () => _skipBy(15),
                              ),
                            ],
                          ),
                        ],
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 48),
                        child: CircularProgressIndicator(
                          color: colorScheme.secondary,
                        ),
                      ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _formatTime(double sec) {
    final total = sec.round();
    final min = (total ~/ 60).toString().padLeft(2, '0');
    final s = (total % 60).toString().padLeft(2, '0');
    return "$min:$s";
  }
}
