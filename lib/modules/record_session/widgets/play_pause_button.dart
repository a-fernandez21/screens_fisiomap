import 'package:flutter/material.dart';

/// Large circular play/pause button
class PlayPauseButton extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const PlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPlayPause,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          size: 32,
          color: Colors.grey[900],
        ),
      ),
    );
  }
}
