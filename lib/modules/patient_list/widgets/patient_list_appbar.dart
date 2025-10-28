import 'package:flutter/material.dart';

/// AppBar for patient list screen
class PatientListAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PatientListAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pacientes',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 45, 183, 221),
      elevation: 4,
      centerTitle: true,
    );
  }
}
