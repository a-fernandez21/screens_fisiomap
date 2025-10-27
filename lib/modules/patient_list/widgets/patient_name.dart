import 'package:flutter/material.dart';

/// Widget that displays the patient's name.
class PatientNameWidget extends StatelessWidget {
  final String name;

  const PatientNameWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}
