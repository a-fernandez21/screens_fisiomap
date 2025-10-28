import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/medical_history_page_vm.dart';
import '../widgets/medical_history_widgets.dart';
import '../../../models/patient.dart';

/// Medical History Page - Shows patient's medical records
class MedicalHistoryPage extends StatelessWidget {
  final Patient patient;

  const MedicalHistoryPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<MedicalHistoryPageViewModel>(
      model: MedicalHistoryPageViewModel(patient: patient),
      onModelReady: (model) => model.initialize(),
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: MedicalHistoryAppBar(patientName: model.patient.name),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Patient summary card
                  PatientSummaryWidget(patient: model.patient),
                  const SizedBox(height: 24),
                  // Section header with records count
                  SectionTitleWidget(
                    title: 'Historial Clínico',
                    subtitle: '${model.medicalRecords.length} registros',
                  ),
                  const SizedBox(height: 16),
                  // Display loading, empty state, or records list
                  if (model.busy)
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (model.isEmpty)
                    const Expanded(child: EmptyMedicalRecordsWidget())
                  else
                    MedicalRecordsListWidget(
                      medicalRecords: model.medicalRecords,
                      onRecordTap:
                          (record) => model.onRecordTap(context, record),
                    ),
                ],
              ),
            ),
            floatingActionButton: AddRecordFAB(
              onPressed: () => model.addNewRecord(context),
            ),
          ),
    );
  }
}
