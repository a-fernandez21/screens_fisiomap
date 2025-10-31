import 'package:flutter/material.dart';
import 'timeline_row.dart';
import 'audio_progress_bar.dart';
import 'playback_controls.dart';

/// Audio player widget with gradient background and playback controls
class AudioPlayerWidget extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind10;
  final VoidCallback onForward10;
  final VoidCallback onSkipPrevious;
  final VoidCallback onSkipNext;
  final bool isCompact;
  final Duration currentPosition;
  final Duration totalDuration;

  const AudioPlayerWidget({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onRewind10,
    required this.onForward10,
    required this.onSkipPrevious,
    required this.onSkipNext,
    this.isCompact = false,
    required this.currentPosition,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(isCompact ? 8 : 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 122, 239, 255),
            Color.fromARGB(255, 255, 184, 85),
          ],
        ),
        borderRadius: BorderRadius.circular(isCompact ? 12 : 20),
      ),
      child: isCompact ? _buildCompactLayout() : _buildNormalLayout(),
    );
  }

  // Compact layout for when keyboard is open
  Widget _buildCompactLayout() {
    return Row(
      children: [
        // Play/Pause button
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            padding: EdgeInsets.zero,
            icon: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
              color: const Color.fromARGB(255, 122, 239, 255),
              size: 24,
            ),
            onPressed: onPlayPause,
          ),
        ),
        const SizedBox(width: 12),
        // Progress bar
        Expanded(
          child: AudioProgressBar(
            isPlaying: isPlaying,
            currentPosition: currentPosition,
            totalDuration: totalDuration,
          ),
        ),
      ],
    );
  }

  // Normal layout for when keyboard is closed
  Widget _buildNormalLayout() {
    return Column(
      children: [
        TimelineRow(
          currentPosition: currentPosition,
          totalDuration: totalDuration,
        ),
        const SizedBox(height: 8),
        AudioProgressBar(
          isPlaying: isPlaying,
          currentPosition: currentPosition,
          totalDuration: totalDuration,
        ),
        const SizedBox(height: 20),
        PlaybackControls(
          isPlaying: isPlaying,
          onPlayPause: onPlayPause,
          onRewind10: onRewind10,
          onForward10: onForward10,
          onSkipPrevious: onSkipPrevious,
          onSkipNext: onSkipNext,
        ),
      ],
    );
  }
}
