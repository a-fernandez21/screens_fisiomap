import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';

/// Widget displaying medical record header with type and date.
class RecordHeaderWidget extends StatelessWidget {
  final MedicalRecord record;

  const RecordHeaderWidget({
    super.key,
    required this.record,
  });

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
              Icon(record.typeIcon, size: 16, color: record.typeColor),
              const SizedBox(width: 6),
              Text(
                record.type,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: record.typeColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              record.date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
