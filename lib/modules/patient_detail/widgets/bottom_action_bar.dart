import 'package:flutter/material.dart';
import 'bottom_action_button.dart';

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
      height: 74,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BottomActionButton(
            icon: Icons.trending_up,
            text: 'Nuevo Seguimiento',
            color: Colors.green,
            onPressed: onNewFollowUp,
          ),

          SizedBox(width: 8),

          BottomActionButton(
            icon: Icons.assignment,
            text: 'Nueva Anamnesis',
            color: Colors.blue,
            onPressed: onNewAnamnesis,
          ),
        ],
      ),
    );
  }
}
