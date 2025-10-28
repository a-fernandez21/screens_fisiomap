import 'package:flutter/material.dart';

/// Empty state widget when no medical records exist
class EmptyMedicalRecordsWidget extends StatelessWidget {
  const EmptyMedicalRecordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.medical_services_outlined, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No hay historias clínicas registradas',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
