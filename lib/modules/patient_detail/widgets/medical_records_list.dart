import 'package:flutter/material.dart';
import '../../../models/medical_record.dart';

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
              _RecordHeaderWidget(record: record),
              const SizedBox(height: 12),
              _RecordFooterWidget(record: record),
            ],
          ),
        ),
      ),
    );
  }
}

/// Header displaying record type badge and date
class _RecordHeaderWidget extends StatelessWidget {
  final MedicalRecord record;

  const _RecordHeaderWidget({required this.record});

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
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            record.date,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

/// Footer displaying doctor name and status badge
class _RecordFooterWidget extends StatelessWidget {
  final MedicalRecord record;

  const _RecordFooterWidget({required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            'Dr: ${record.doctor}',
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
