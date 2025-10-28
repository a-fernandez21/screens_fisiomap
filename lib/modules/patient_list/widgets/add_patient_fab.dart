import 'package:flutter/material.dart';

/// Floating action button for adding new patients
class AddPatientFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const AddPatientFAB({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      child: const Icon(Icons.person_add),
    );
  }
}
