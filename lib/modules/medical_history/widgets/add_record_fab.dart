import 'package:flutter/material.dart';

/// Floating action button for adding new medical records
class AddRecordFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AddRecordFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
