import 'package:flutter/material.dart';

/// Arrow icon indicating card interactivity
class ArrowIconWidget extends StatelessWidget {
  const ArrowIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16);
  }
}
