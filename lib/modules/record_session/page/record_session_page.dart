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
      builder: (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: RecordSessionAppBar(sessionType: model.sessionType),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Audio player widget
                  AudioPlayerWidget(
                    isPlaying: model.isPlaying,
                    onPlayPause: model.togglePlayPause,
                  ),
                  const SizedBox(height: 16),
                  // Editable text container for session notes
                  Expanded(
                    child: EditableTextContainer(
                      controller: model.textController,
                      isEditing: model.isEditing,
                      onTap: model.onTextFieldTap,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action buttons
                  ActionButtonsWidget(
                    onSaveChanges: () => model.saveChanges(context),
                    onConfirmReview: () => model.confirmReview(context),
                  ),
                ],
              ),
            ),
          ),
    );
  }
}
