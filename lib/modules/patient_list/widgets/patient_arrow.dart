import 'package:flutter/material.dart';

/// Widget that displays an arrow icon as action indicator.
class ArrowIconWidget extends StatelessWidget {
  const ArrowIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16);
  }
}
