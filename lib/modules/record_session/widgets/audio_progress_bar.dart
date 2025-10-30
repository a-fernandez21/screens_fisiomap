import 'package:flutter/material.dart';

/// Progress bar showing playback position
class AudioProgressBar extends StatelessWidget {
  final bool isPlaying;
  final Duration currentPosition;
  final Duration totalDuration;

  const AudioProgressBar({
    super.key,
    required this.isPlaying,
    required this.currentPosition,
    required this.totalDuration,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate progress (0.0 to 1.0)
    final progress =
        totalDuration.inMilliseconds > 0
            ? currentPosition.inMilliseconds / totalDuration.inMilliseconds
            : 0.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: progress.clamp(0.0, 1.0),
        minHeight: 4,
        backgroundColor: Colors.grey[700],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
