import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';

/// Widget displaying medical record footer with doctor and status.
class RecordFooterWidget extends StatelessWidget {
  final MedicalRecord record;

  const RecordFooterWidget({
    super.key,
    required this.record,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            record.doctor,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: record.statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: record.statusColor.withOpacity(0.3)),
          ),
          child: Text(
            record.status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: record.statusColor,
            ),
          ),
        ),
      ],
    );
  }
}
