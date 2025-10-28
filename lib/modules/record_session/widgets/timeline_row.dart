import 'package:flutter/material.dart';

/// Timeline displaying current and total duration
class TimelineRow extends StatelessWidget {
  const TimelineRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '0:00',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          '3:45',
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
