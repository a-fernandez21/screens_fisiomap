import 'package:flutter/material.dart';

/// AppBar for medical history screen with back navigation
class MedicalHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String patientName;

  const MedicalHistoryAppBar({super.key, required this.patientName});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Historial Clínico',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
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
