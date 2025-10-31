import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import 'package:screens_fisiomap/modules/patient_detail/vm/patient_detail_page_vm.dart';
import 'package:screens_fisiomap/modules/patient_detail/widgets/patient_detail_widgets.dart';
import 'package:screens_fisiomap/models/patient.dart';
import 'package:screens_fisiomap/modules/record_session/page/record_session_page.dart';
import 'package:screens_fisiomap/modules/voice_recorder/page/voice_recorder_page.dart';

/// Patient Detail Page - Shows patient info and medical history
class PatientDetailPage extends StatelessWidget {
  final Patient patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PatientDetailPageViewModel>(
      model: PatientDetailPageViewModel(patient: patient),
      onModelReady: (model) => model.onInit(),
      builder:
          (context, model, child) => Scaffold(
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
                          subtitle:
                              '${model.anamnesisRecords.length} registros',
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
                            anamnesisRecords: model.anamnesisRecords,
                            onRecordTap: (record) async {
                              model.logAnamnesisRecordTap(record);
                              final String? result =
                                  await Navigator.push<String>(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => RecordSessionPage(
                                            patient: model.patient,
                                            sessionType: 'Anamnesis',
                                            recordId: record.id,
                                            audioPath: record.audioPath,
                                          ),
                                    ),
                                  );
                              model.handleAnamnesisSessionResult(
                                record.id,
                                result,
                              );
                            },
                            onNewFollowUp: (record) async {
                              final String? result =
                                  await Navigator.push<String>(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => RecordSessionPage(
                                            patient: model.patient,
                                            sessionType: 'Seguimiento',
                                          ),
                                    ),
                                  );
                              model.handleNewFollowUpResult(result);
                            },
                            onSeguimientoTap: (seguimiento) async {
                              debugPrint(
                                'Seguimiento tapped: ${seguimiento.id}',
                              );
                              final String? result =
                                  await Navigator.push<String>(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => RecordSessionPage(
                                            patient: model.patient,
                                            sessionType: 'Seguimiento',
                                            recordId: seguimiento.id,
                                          ),
                                    ),
                                  );
                              model.handleSeguimientoSessionResult(
                                seguimiento.id,
                                result,
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                final String? audioPath = await Navigator.push<String>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VoiceRecorderPage(),
                  ),
                );

                if (audioPath != null) {
                  model.createAnamnesisWithAudio(audioPath: audioPath);
                }
              },
              backgroundColor: const Color.fromARGB(255, 13, 175, 229),
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
    );
  }
}
