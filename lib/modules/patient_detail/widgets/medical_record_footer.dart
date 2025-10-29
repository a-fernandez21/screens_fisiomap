import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/medical_record.dart';

/// Footer displaying doctor name and status badge
class MedicalRecordFooter extends StatelessWidget {
  final MedicalRecord record;

  const MedicalRecordFooter({super.key, required this.record});

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
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: record.statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: record.statusColor.withOpacity(0.3)),
          ),
          child: Text(
            record.status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: record.statusColor,
            ),
          ),
        ),
      ],
    );
  }
}
