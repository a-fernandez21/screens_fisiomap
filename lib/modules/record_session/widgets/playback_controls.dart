import 'package:flutter/material.dart';
import 'play_pause_button.dart';
import 'player_button.dart';

/// Row containing all playback control buttons
class PlaybackControls extends StatelessWidget {
  final bool isPlaying;
  final VoidCallback onPlayPause;

  const PlaybackControls({
    super.key,
    required this.isPlaying,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        PlayerButton(icon: Icons.replay_10, size: 28, onPressed: () {}),
        PlayerButton(icon: Icons.skip_previous, size: 32, onPressed: () {}),
        PlayPauseButton(isPlaying: isPlaying, onPlayPause: onPlayPause),
        PlayerButton(icon: Icons.skip_next, size: 32, onPressed: () {}),
        PlayerButton(icon: Icons.forward_10, size: 28, onPressed: () {}),
      ],
    );
  }
}
