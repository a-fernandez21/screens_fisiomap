import 'package:flutter/material.dart';
import 'play_pause_button.dart';
import 'player_button.dart';

/// Row containing all playback control buttons
class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;
  final VoidCallback onRewind10;
  final VoidCallback onForward10;
  final VoidCallback onSkipPrevious;
  final VoidCallback onSkipNext;

  const PlaybackControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
    required this.onRewind10,
    required this.onForward10,
    required this.onSkipPrevious,
    required this.onSkipNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlayerButton(icon: Icons.replay_10, size: 28, onPressed: onRewind10),
        PlayerButton(
          icon: Icons.skip_previous,
          size: 32,
          onPressed: onSkipPrevious,
        ),
        PlayPauseButton(isPlaying: isPlaying, onPlayPause: onPlayPause),
        PlayerButton(icon: Icons.skip_next, size: 32, onPressed: onSkipNext),
        PlayerButton(icon: Icons.forward_10, size: 28, onPressed: onForward10),
      ],
    );
  }
}
