import 'package:flutter/material.dart';

/// Text widget displaying patient's name
class PatientNameWidget extends StatelessWidget {
  final String name;
  final String? searchQuery;

  const PatientNameWidget({
    super.key,
    required this.name,
    this.searchQuery,
  });

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
