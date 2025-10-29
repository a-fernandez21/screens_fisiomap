import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';

/// ViewModel for RecordSessionPage.
///
/// Manages:
/// - Audio player state (play/pause simulation)
/// - Text editing state
/// - Session actions (save changes, confirm review)
/// - Navigation with result return
class RecordSessionPageViewModel extends BaseVM {
  final Patient patient;
  final String sessionType;
  final int? recordId;

  ///check for correct implementation of saved recording api call
  bool _isRecordingSaved = false;

  get isRecordingSaved => _isRecordingSaved;

  set isRcordingSaved(bool value) {
    _isRecordingSaved = value;
    notifyListeners();
  }

  // Text controller for editable notes
  final TextEditingController textController = TextEditingController();

  // Private state variables
  bool _isPlaying = false;
  String _audioStatus = 'Sin audio';
  bool _isEditing = false;
  String _htmlContent = '';
  bool _isEditorFocused = false;

  // Getters for state access
  bool get isPlaying => _isPlaying;
  String get audioStatus => _audioStatus;
  bool get isEditing => _isEditing;
  String get htmlContent => _htmlContent;
  bool get isEditorFocused => _isEditorFocused;

  // Setters with notifyListeners
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  set audioStatus(String value) {
    _audioStatus = value;
    notifyListeners();
  }

  set isEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  set htmlContent(String value) {
    _htmlContent = value;
    notifyListeners();
  }

  set isEditorFocused(bool value) {
    _isEditorFocused = value;
    notifyListeners();
  }

  RecordSessionPageViewModel({
    required this.patient,
    required this.sessionType,
    this.recordId,
  });

  /// Initialize the ViewModel with default text.
  /// Called from BaseWidget's onModelReady
  Future<void> onInit() async {
    textController.text =
        'Haz clic aquí para empezar a escribir las notas de la sesión...';
  }

  /// Toggle play/pause audio playback.
  void togglePlayPause() {
    isPlaying = !isPlaying;
    audioStatus = isPlaying ? 'Reproduciendo...' : 'Pausado';

    // Simulate audio playback finishing after 3 seconds
    if (isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!disposed && isPlaying) {
          isPlaying = false;
          audioStatus = 'Reproducción finalizada';
        }
      });
    }
  }

  /// Handle text field tap to start editing.
  void onTextFieldTap() {
    isEditing = true;
    if (textController.text ==
        'Haz clic aquí para empezar a escribir las notas de la sesión...') {
      textController.clear();
    }
  }

  /// Handle HTML content changes from the editor
  void onHtmlContentChanged(String content) {
    htmlContent = content;
    debugPrint('📝 HTML content updated: ${content.length} characters');
  }

  /// Handle when HTML editor gains focus
  void onEditorFocused() {
    isEditorFocused = true;
    debugPrint('🎯 Editor focused - hiding audio player');
  }

  /// Handle when HTML editor loses focus
  void onEditorUnfocused() {
    isEditorFocused = false;
    debugPrint('🎯 Editor unfocused - showing audio player');
  }

  /// Save HTML content
  Future<bool> saveHtmlContent() async {
    debugPrint('💾 Saving HTML content: ${htmlContent.length} characters');
    try {
      // In a real app, this would save to a file or send to server
      // For now, we'll simulate success
      await Future.delayed(const Duration(milliseconds: 500));
      isRcordingSaved = true;
      return true;
    } catch (e) {
      debugPrint('❌ Error saving HTML content: $e');
      return false;
    }
  }

  /// Save changes and return result.
  /// Returns true if saved successfully, false otherwise.
  Future<bool> saveChanges() async {
    debugPrint('💾 Botón Guardar Cambios presionado');
    // API call to save
    if (isRecordingSaved) {
      return true;
    } else {
      return false;
    }
  }

  /// Confirm review and return 'Completado' status.
  /// Returns the status string to be used by the view for navigation.
  String confirmReview() {
    debugPrint('✅ Botón Confirmar Revisión presionado');
    debugPrint('🚪 Devolviendo estado: Completado');
    return 'Completado';
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
