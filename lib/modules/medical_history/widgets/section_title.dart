import 'package:flutter/material.dart';

/// Widget that displays section title with optional subtitle.
class SectionTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const SectionTitleWidget({
    super.key,
    required this.title,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}
