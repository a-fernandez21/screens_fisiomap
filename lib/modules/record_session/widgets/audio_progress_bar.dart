import 'package:flutter/material.dart';

/// Progress bar showing playback position
class AudioProgressBar extends StatelessWidget {
  final bool isPlaying;

  const AudioProgressBar({super.key, required this.isPlaying});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: LinearProgressIndicator(
        value: isPlaying ? 0.3 : 0.0,
        minHeight: 4,
        backgroundColor: Colors.grey[700],
        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }
}
