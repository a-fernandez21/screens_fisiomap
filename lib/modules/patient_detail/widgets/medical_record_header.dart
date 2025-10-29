import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';

/// Header displaying record type badge and date
class MedicalRecordHeader extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordHeader({super.key, required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: record.typeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: record.typeColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(record.typeIcon, size: 18, color: record.typeColor),
              const SizedBox(width: 8),
              Text(
                record.type,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: record.typeColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(
          record.date,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
