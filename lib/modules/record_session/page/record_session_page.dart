import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/record_session_page_vm.dart';
import '../widgets/record_session_widgets.dart';
import '../../../models/patient.dart';

/// Record Session Page - Audio recording/playback and session notes editing
class RecordSessionPage extends StatelessWidget {
  final Patient patient;
  final String sessionType;
  final int? recordId;

  const RecordSessionPage({
    super.key,
    required this.patient,
    required this.sessionType,
    this.recordId,
  });

  @override
  Widget build(BuildContext context) {
    return BaseWidget<RecordSessionPageViewModel>(
      model: RecordSessionPageViewModel(
        patient: patient,
        sessionType: sessionType,
        recordId: recordId,
      ),
      onModelReady: (model) => model.onInit(),
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: RecordSessionAppBar(sessionType: model.sessionType),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Audio player widget - Always visible
                  AudioPlayerWidget(
                    isPlaying: model.isPlaying,
                    onPlayPause: model.togglePlayPause,
                  ),
                  const SizedBox(height: 16),
                  // HTML Editor widget for session notes
                  Expanded(
                    child: HtmlEditorWidget(
                      onContentChanged: model.onHtmlContentChanged,
                      onFocused: model.onEditorFocused,
                      onUnfocused: model.onEditorUnfocused,
                      onSave: () async {
                        bool success = await model.saveHtmlContent();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                success
                                    ? 'Documento guardado correctamente'
                                    : 'Error al guardar el documento',
                              ),
                              backgroundColor:
                                  success ? Colors.green[600] : Colors.red[600],
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  ActionButtonsWidget(
                    onSaveChanges: () async {
                      bool res = await model.saveHtmlContent();
                      if (res) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Historia clínica guardada para ${patient.name}',
                              ),
                              backgroundColor: Colors.green[600],
                            ),
                          );
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Error al guardar la historia clínica para ${patient.name}',
                              ),
                              backgroundColor: Colors.red[600],
                            ),
                          );
                        }
                      }
                    },
                    onConfirmReview: () {
                      final String status = model.confirmReview();
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Revisión confirmada para ${patient.name}',
                            ),
                            backgroundColor: Colors.blue[600],
                          ),
                        );
                        Navigator.of(context).pop(status);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
