import 'package:flutter/material.dart';
import 'package:screens_fisiomap/constants/app_colors.dart';
import 'package:screens_fisiomap/models/anamnesis_record.dart';

/// Header displaying anamnesis icon and date
class MedicalRecordHeader extends StatelessWidget {
  final AnamnesisRecord record;

  const MedicalRecordHeader({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(record.typeIcon, size: 20, color: AppColors.orange),
        const SizedBox(width: 8),
        const Text(
          'Anamnesis',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
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
