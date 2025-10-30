import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/medical_record.dart';

/// Footer displaying doctor name and new follow-up button
class MedicalRecordFooter extends StatelessWidget {
  final MedicalRecord record;
  final VoidCallback? onNewFollowUp;

  const MedicalRecordFooter({
    super.key,
    required this.record,
    this.onNewFollowUp,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            record.doctor,
            style: TextStyle(fontSize: 13, color: Colors.grey[600]),
          ),
        ),
        OutlinedButton.icon(
          onPressed: onNewFollowUp,
          icon: const Icon(Icons.add, size: 16),
          label: const Text(
            'Nuevo seguimiento',
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
          style: OutlinedButton.styleFrom(
            foregroundColor: const Color.fromARGB(255, 235, 188, 0),
            side: const BorderSide(
              color: Color.fromARGB(255, 235, 188, 0),
              width: 1.5,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
        ),
      ],
    );
  }
}
