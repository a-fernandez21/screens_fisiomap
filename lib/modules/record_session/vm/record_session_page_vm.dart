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

  // Text controller for editable notes
  final TextEditingController textController = TextEditingController();

  // Audio player state
  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;

  String _audioStatus = 'Sin audio';
  String get audioStatus => _audioStatus;

  // Text editing state
  bool _isEditing = false;
  bool get isEditing => _isEditing;

  RecordSessionPageViewModel({
    required this.patient,
    required this.sessionType,
    this.recordId,
  });

  /// Initialize the ViewModel with default text.
  void initialize() {
    textController.text =
        'Haz clic aquí para empezar a escribir las notas de la sesión...';
  }

  /// Toggle play/pause audio playback.
  void togglePlayPause() {
    _isPlaying = !_isPlaying;
    _audioStatus = _isPlaying ? 'Reproduciendo...' : 'Pausado';
    notifyListeners();

    // Simulate audio playback finishing after 3 seconds
    if (_isPlaying) {
      Future.delayed(const Duration(seconds: 3), () {
        if (!disposed && _isPlaying) {
          _isPlaying = false;
          _audioStatus = 'Reproducción finalizada';
          notifyListeners();
        }
      });
    }
  }

  /// Handle text field tap to start editing.
  void onTextFieldTap() {
    _isEditing = true;
    if (textController.text ==
        'Haz clic aquí para empezar a escribir las notas de la sesión...') {
      textController.clear();
    }
    notifyListeners();
  }

  /// Save changes and return 'Pendiente' status.
  void saveChanges(BuildContext context) {
    debugPrint('💾 Botón Guardar Cambios presionado');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cambios guardados para ${patient.name}'),
        backgroundColor: Colors.green[600],
      ),
    );

    debugPrint('🚪 Cerrando pantalla con estado: Pendiente');
    Navigator.of(context).pop('Pendiente');
  }

  /// Confirm review and return 'Completado' status.
  void confirmReview(BuildContext context) {
    debugPrint('✅ Botón Confirmar Revisión presionado');

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Revisión confirmada para ${patient.name}'),
        backgroundColor: Colors.blue[600],
      ),
    );

    debugPrint('🚪 Cerrando pantalla con estado: Completado');
    Navigator.of(context).pop('Completado');
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}
