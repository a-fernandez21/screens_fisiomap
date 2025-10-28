import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/patient_detail_page_vm.dart';
import '../widgets/patient_detail_widgets.dart';
import '../../../models/patient.dart';

/// Patient Detail Page - Shows patient info and medical history
class PatientDetailPage extends StatelessWidget {
  final Patient patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PatientDetailPageViewModel>(
      model: PatientDetailPageViewModel(patient: patient),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[50],
            appBar: PatientDetailAppBar(patientName: model.patient.name),
            body: Column(
              children: [
                // Fixed patient info container at top
                Container(
                  color: Colors.grey[50],
                  padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                  child: PatientInfoContainer(patient: model.patient),
                ),
                // Medical history section
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        SectionTitleWidget(
                          title: 'Historial Clínico',
                          subtitle: '${model.medicalRecords.length} registros',
                        ),
                        const SizedBox(height: 8),
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
                            onRecordTap: (record) => model.onRecordTap(context, record),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomActionBar(
              onNewFollowUp: () => model.onNewFollowUp(context),
              onNewAnamnesis: () => model.onNewAnamnesis(context),
            ),
          ),
    );
  }
}
