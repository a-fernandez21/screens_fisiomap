import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/record_session_page_vm.dart';
import '../widgets/record_session_widgets.dart';
import '../../../models/patient.dart';

/// Main screen for recording/playing audio and editing session notes.
///
/// MVVM Architecture:
/// - VIEW: This file (UI composition only)
/// - LOGIC: RecordSessionPageViewModel (vm/)
/// - WIDGETS: Reusable components (widgets/)
///
/// Used for both new anamnesis and new follow-up sessions.
///
/// Includes:
/// - iPhone-style audio player
/// - Editable text container for notes
/// - Action buttons (Save Changes / Confirm Review)
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
      onModelReady: (model) => model.initialize(),
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: RecordSessionAppBar(sessionType: model.sessionType),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // iPhone-style audio player
                  AudioPlayerWidget(
                    isPlaying: model.isPlaying,
                    onPlayPause: model.togglePlayPause,
                  ),
                  const SizedBox(height: 16),
                  // Editable text container filling available space
                  Expanded(
                    child: EditableTextContainer(
                      controller: model.textController,
                      isEditing: model.isEditing,
                      onTap: model.onTextFieldTap,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Action buttons at bottom
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
