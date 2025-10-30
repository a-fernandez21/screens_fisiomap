import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screens_fisiomap/models/anamnesis_record.dart';
import 'package:screens_fisiomap/models/seguimiento_record.dart';
import 'package:screens_fisiomap/modules/patient_detail/vm/patient_detail_page_vm.dart';
import 'medical_record_card.dart';

/// Scrollable list displaying all anamnesis records with their seguimientos
class MedicalRecordsListWidget extends StatelessWidget {
  final List<AnamnesisRecord> anamnesisRecords;
  final Function(AnamnesisRecord) onRecordTap;
  final Function(AnamnesisRecord)? onNewFollowUp;
  final Function(SeguimientoRecord)? onSeguimientoTap;

  const MedicalRecordsListWidget({
    super.key,
    required this.anamnesisRecords,
    required this.onRecordTap,
    this.onNewFollowUp,
    this.onSeguimientoTap,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<PatientDetailPageViewModel>(context);

    return Expanded(
      child: ListView.builder(
        itemCount: anamnesisRecords.length,
        itemBuilder: (context, index) {
          final record = anamnesisRecords[index];
          final seguimientos = model.getSeguimientosForAnamnesis(record.id);

          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MedicalRecordCard(
              record: record,
              seguimientos: seguimientos,
              onTap: () => onRecordTap(record),
              onNewFollowUp:
                  onNewFollowUp != null ? () => onNewFollowUp!(record) : null,
              onSeguimientoTap: onSeguimientoTap,
            ),
          );
        },
      ),
    );
  }
}
