import 'package:flutter/material.dart';
import 'timeline_row.dart';
import 'audio_progress_bar.dart';
import 'playback_controls.dart';

/// Audio player widget with gradient background and playback controls
class AudioPlayerWidget extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const AudioPlayerWidget({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 122, 239, 255),
            Color.fromARGB(255, 255, 184, 85),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const TimelineRow(),
          const SizedBox(height: 8),
          AudioProgressBar(isPlaying: isPlaying),
          const SizedBox(height: 20),
          PlaybackControls(isPlaying: isPlaying, onPlayPause: onPlayPause),
        ],
      ),
    );
  }
}
