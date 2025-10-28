import 'package:flutter/material.dart';

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
          ProgressBar(isPlaying: isPlaying),
          const SizedBox(height: 20),
          PlaybackControls(isPlaying: isPlaying, onPlayPause: onPlayPause),
        ],
      ),
    );
  }
}

/// Timeline displaying current and total duration
class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '0:00',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '3:45',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

/// Progress bar showing playback position
class ProgressBar extends StatelessWidget {
  final bool isPlaying;

  const ProgressBar({super.key, required this.isPlaying});

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

/// Standard player control button
class PlayerButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  const PlayerButton({
    super.key,
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size, color: Colors.white),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}
