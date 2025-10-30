import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/medical_record.dart';

/// Header displaying record type badge and date
class MedicalRecordHeader extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordHeader({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(record.typeIcon, size: 20, color: record.typeColor),
        const SizedBox(width: 8),
        Text(
          record.date,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
