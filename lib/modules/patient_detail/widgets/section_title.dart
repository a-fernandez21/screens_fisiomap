import 'package:flutter/material.dart';

/// Section title widget with main title and optional subtitle.
class SectionTitleWidget extends StatelessWidget {
  final String title;
  final String subtitle;

  const SectionTitleWidget({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        Text(subtitle, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
      ],
    );
  }
}
