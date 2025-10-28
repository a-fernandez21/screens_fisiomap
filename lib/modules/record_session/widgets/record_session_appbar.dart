import 'package:flutter/material.dart';

/// AppBar displaying session type with back navigation
class RecordSessionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String sessionType;

  const RecordSessionAppBar({super.key, required this.sessionType});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        sessionType,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 45, 183, 221),
      elevation: 4,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
