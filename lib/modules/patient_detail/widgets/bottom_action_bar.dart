import 'package:flutter/material.dart';

/// Bottom action bar with quick access buttons for creating new sessions
class BottomActionBar extends StatelessWidget {
  final VoidCallback onNewFollowUp;
  final VoidCallback onNewAnamnesis;

  const BottomActionBar({
    super.key,
    required this.onNewFollowUp,
    required this.onNewAnamnesis,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: BottomActionButton(
              icon: Icons.trending_up,
              text: 'Nuevo Seguimiento',
              color: Colors.green,
              onPressed: onNewFollowUp,
            ),
          ),
          Expanded(
            child: BottomActionButton(
              icon: Icons.assignment,
              text: 'Nueva Anamnesis',
              color: Colors.blue,
              onPressed: onNewAnamnesis,
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual action button within bottom bar
class BottomActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const BottomActionButton({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: color),
            const SizedBox(height: 4),
            Text(
              text,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
