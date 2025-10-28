import 'package:flutter/material.dart';

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
