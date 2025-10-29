import 'package:flutter/material.dart';

/// Widget displaying medical record description.
class RecordDescriptionWidget extends StatelessWidget {
  final String description;

  const RecordDescriptionWidget({
    super.key,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        height: 1.3,
      ),
    );
  }
}
