import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/medical_record.dart';
import 'medical_record_card.dart';

/// Scrollable list displaying all medical records
class MedicalRecordsListWidget extends StatelessWidget {
  final List<MedicalRecord> medicalRecords;
  final Function(MedicalRecord) onRecordTap;
  final Function(MedicalRecord)? onNewFollowUp;

  const MedicalRecordsListWidget({
    super.key,
    required this.medicalRecords,
    required this.onRecordTap,
    this.onNewFollowUp,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final record = medicalRecords[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MedicalRecordCard(
              record: record,
              onTap: () => onRecordTap(record),
              onNewFollowUp:
                  onNewFollowUp != null ? () => onNewFollowUp!(record) : null,
            ),
          );
        },
      ),
    );
  }
}
