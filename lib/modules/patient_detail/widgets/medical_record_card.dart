import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';
import 'medical_record_header.dart';
import 'medical_record_footer.dart';

/// Interactive card displaying individual medical record details
class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;
  final VoidCallback onTap;

  const MedicalRecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MedicalRecordHeader(record: record),
              const SizedBox(height: 12),
              MedicalRecordFooter(record: record),
            ],
          ),
        ),
      ),
    );
  }
}
