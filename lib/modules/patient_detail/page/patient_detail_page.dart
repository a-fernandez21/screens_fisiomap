import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import 'package:screens_fisiomap/modules/patient_detail/vm/patient_detail_page_vm.dart';
import 'package:screens_fisiomap/modules/patient_detail/widgets/patient_detail_widgets.dart';
import 'package:screens_fisiomap/modules/patient_detail/widgets/edit_notes_dialog.dart';
import 'package:screens_fisiomap/models/patient.dart';
import 'package:screens_fisiomap/modules/record_session/page/record_session_page.dart';
import 'package:screens_fisiomap/modules/voice_recorder/page/voice_recorder_page.dart';

/// Patient Detail Page - Shows patient info and medical history
class PatientDetailPage extends StatefulWidget {
  final Patient patient;

  const PatientDetailPage({super.key, required this.patient});

  @override
  State<PatientDetailPage> createState() => _PatientDetailPageState();
}

class _PatientDetailPageState extends State<PatientDetailPage> {
  String? _patientNotes;
  VoidCallback? _expandPatientInfo;

  @override
  void initState() {
    super.initState();
    // Initialize notes from patient data if available
    _patientNotes = null; // Start with no notes
  }

  void _setExpandCallback(VoidCallback callback) {
    _expandPatientInfo = callback;
  }

  Future<void> _editNotes() async {
    final String? newNotes = await showDialog<String>(
      context: context,
      builder: (context) => EditNotesDialog(initialNotes: _patientNotes),
    );

    if (newNotes != null) {
      setState(() {
        _patientNotes = newNotes.isEmpty ? null : newNotes;
      });
      // Expand the patient info container to show the saved note
      _expandPatientInfo?.call();
      // TODO: Save notes to database or state management
      debugPrint('Notes updated for ${widget.patient.name}: $_patientNotes');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PatientDetailPageViewModel>(
      model: PatientDetailPageViewModel(patient: widget.patient),
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
                  child: PatientInfoContainer(
                    patient: model.patient,
                    onEditNotes: _editNotes,
                    onExpandCallbackReady: _setExpandCallback,
                    currentNotes: _patientNotes,
                  ),
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
                          title: 'Historia Clínica',
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
                              // Show consultation type selection dialog
                              final String? consultationType =
                                  await showDialog<String>(
                                    context: context,
                                    builder:
                                        (context) =>
                                            const ConsultationTypeDialog(),
                                  );

                              // If user selected a consultation type, create seguimiento and navigate
                              if (consultationType != null &&
                                  context.mounted) {
                                // Create new seguimiento record
                                final int seguimientoId =
                                    model.createNewSeguimiento(
                                  anamnesisId: record.id,
                                  consultationType: consultationType,
                                );

                                // Navigate to record session with the new seguimiento
                                final String? result =
                                    await Navigator.push<String>(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => RecordSessionPage(
                                              patient: model.patient,
                                              sessionType: 'Seguimiento',
                                              recordId: seguimientoId,
                                              consultationType:
                                                  consultationType,
                                            ),
                                      ),
                                    );
                                model.handleNewFollowUpResult(result);
                              }
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
              // Navigate to VoiceRecorderPage
              final audioPath = await Navigator.push<String>(
                context,
                MaterialPageRoute(
                  builder: (context) => VoiceRecorderPage(patient: model.patient),
                ),
              );                if (audioPath != null) {
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
