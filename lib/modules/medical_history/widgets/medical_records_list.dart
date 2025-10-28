import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';
import 'medical_record_card.dart';

/// Scrollable list rendering all medical record cards
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
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final MedicalRecord record = medicalRecords[index];
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
