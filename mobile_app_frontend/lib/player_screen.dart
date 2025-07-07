import 'package:flutter/material.dart';
import 'models/audiobook.dart';

/// A player screen providing chapter-based navigation and playback controls for an audiobook.
/// Integrates with Audiobook models, presenting chapters as selectable list-items,
/// and providing play/pause/next/previous controls optimized for mobile.
///
/// This widget should be pushed after a purchase and when opening a book from the library.
// PUBLIC_INTERFACE
class PlayerScreen extends StatefulWidget {
  final Audiobook audiobook;
  final int initialChapter;
  final bool autoPlay;

  /// Creates a chapter-based audiobook player screen.
  ///
  /// [audiobook]: The currently selected Audiobook model.
  /// [initialChapter]: Which chapter (zero-based) to start at.
  /// [autoPlay]: If true, playback auto-starts when the player opens.
  const PlayerScreen({
    super.key,
    required this.audiobook,
    this.initialChapter = 0,
    this.autoPlay = false,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  // Simulate playback states
  bool isPlaying = false;
  int currentChapter = 0;

  @override
  void initState() {
    super.initState();
    currentChapter = widget.initialChapter;
    isPlaying = widget.autoPlay;
  }

  // PUBLIC_INTERFACE
  void play() {
    setState(() {
      isPlaying = true;
    });
    // TODO: Integrate with audio playback service or player backend
  }

  // PUBLIC_INTERFACE
  void pause() {
    setState(() {
      isPlaying = false;
    });
    // TODO: Integrate with audio playback service or player backend
  }

  // PUBLIC_INTERFACE
  void goToChapter(int index) {
    setState(() {
      currentChapter = index;
      isPlaying = true;
    });
    // TODO: Integrate with audio play logic (seek to chapter and play)
  }

  // PUBLIC_INTERFACE
  void nextChapter() {
    if (currentChapter < widget.audiobook.chapters.length - 1) {
      goToChapter(currentChapter + 1);
    }
  }

  // PUBLIC_INTERFACE
  void prevChapter() {
    if (currentChapter > 0) {
      goToChapter(currentChapter - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    const accentColor = Color(0xffdcb7d9);
    const secondaryColor = Color(0xff583aee);
    const primaryColor = Color(0xffbadbf7);
    final chapterCount = widget.audiobook.chapters.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text(widget.audiobook.title, style: const TextStyle(color: Colors.black)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Chapter List
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Chapters',
                style: TextStyle(
                  color: secondaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  letterSpacing: 0.5,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: chapterCount,
              separatorBuilder: (_, __) => const Divider(color: primaryColor, height: 1),
              itemBuilder: (context, index) {
                final chapter = widget.audiobook.chapters[index];
                final selected = currentChapter == index;
                return ListTile(
                  selected: selected,
                  selectedTileColor: accentColor.withValues(alpha: 0.08),
                  title: Text(
                    chapter.title,
                    style: TextStyle(
                      fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      color: selected ? secondaryColor : Colors.black87,
                    ),
                  ),
                  trailing: selected
                      ? const Icon(Icons.play_arrow_rounded, color: Colors.green)
                      : null,
                  onTap: () => goToChapter(index),
                  dense: true,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 2.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          // Now playing section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                // Chapter label
                Text(
                  'Now Playing: ${widget.audiobook.chapters[currentChapter].title}',
                  style: const TextStyle(
                      color: secondaryColor, fontWeight: FontWeight.w600, fontSize: 16.0),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 10),
                // Progress bar -- placeholder, as real duration data is not in scope.
                SizedBox(
                  height: 6,
                  child: LinearProgressIndicator(
                    value: 0.3,
                    backgroundColor: primaryColor.withValues(alpha: 0.4),
                    color: accentColor,
                    minHeight: 6,
                  ),
                ),
                const SizedBox(height: 18),
                // Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Previous chapter
                    IconButton(
                        icon: const Icon(Icons.skip_previous_rounded, size: 36),
                        color: secondaryColor,
                        onPressed: currentChapter > 0 ? prevChapter : null),
                    // Play / Pause
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          padding: const WidgetStatePropertyAll(
                              EdgeInsets.symmetric(horizontal: 32, vertical: 12)),
                          backgroundColor: const WidgetStatePropertyAll(accentColor),
                          shape: WidgetStatePropertyAll(
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
                          ),
                        ),
                        onPressed: isPlaying ? pause : play,
                        child: Icon(
                          isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 32,
                        ),
                      ),
                    ),
                    // Next chapter
                    IconButton(
                        icon: const Icon(Icons.skip_next_rounded, size: 36),
                        color: secondaryColor,
                        onPressed: currentChapter < chapterCount - 1 ? nextChapter : null),
                  ],
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
