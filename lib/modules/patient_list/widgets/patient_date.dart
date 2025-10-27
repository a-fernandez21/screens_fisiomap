import 'package:flutter/material.dart';

/// Widget that displays the patient's last visit date.
class PatientLastVisitWidget extends StatelessWidget {
  final String lastVisit;

  const PatientLastVisitWidget({super.key, required this.lastVisit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          'Última visita: $lastVisit',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}