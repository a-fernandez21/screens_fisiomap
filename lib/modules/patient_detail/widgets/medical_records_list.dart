import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';
import 'medical_record_card.dart';

/// Scrollable list displaying all medical records
class MedicalRecordsListWidget extends StatelessWidget {
  final List<MedicalRecord> medicalRecords;
  final Function(MedicalRecord) onRecordTap;

  const MedicalRecordsListWidget({
    super.key,
    required this.medicalRecords,
    required this.onRecordTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final record = medicalRecords[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MedicalRecordCard(
              record: record,
              onTap: () => onRecordTap(record),
            ),
          );
        },
      ),
    );
  }
}
