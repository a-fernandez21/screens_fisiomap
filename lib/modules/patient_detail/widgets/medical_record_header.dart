import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/anamnesis_record.dart';

/// Header displaying anamnesis icon and date
class MedicalRecordHeader extends StatelessWidget {
  final AnamnesisRecord record;

  const MedicalRecordHeader({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(record.typeIcon, size: 20, color: Colors.teal[700]),
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
