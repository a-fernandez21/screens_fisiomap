import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import 'package:screens_fisiomap/models/patient.dart';
import 'package:screens_fisiomap/models/anamnesis_record.dart';
import 'package:screens_fisiomap/models/seguimiento_record.dart';
import 'package:screens_fisiomap/data/anamnesis_data.dart' as anamnesis_data;
import 'package:screens_fisiomap/data/seguimientos_data.dart'
    as seguimientos_data;

/// ViewModel for Patient Detail screen.
///
/// Manages:
/// - Loading medical records for a patient
/// - Updating record status (Pendiente/Revisado)
/// - Handling record tap events
/// - Navigation to record session screen
class PatientDetailPageViewModel extends BaseVM {
  final Patient patient;

  // Private state variables
  List<AnamnesisRecord> _anamnesisRecords = [];
  List<SeguimientoRecord> _allSeguimientos = [];

  // Getters for state access
  List<AnamnesisRecord> get anamnesisRecords => _anamnesisRecords;
  List<SeguimientoRecord> get allSeguimientos => _allSeguimientos;

  // Setters with notifyListeners
  set anamnesisRecords(List<AnamnesisRecord> value) {
    _anamnesisRecords = value;
    notifyListeners();
  }

  set allSeguimientos(List<SeguimientoRecord> value) {
    _allSeguimientos = value;
    notifyListeners();
  }

  PatientDetailPageViewModel({required this.patient});

  /// Initialize ViewModel and load medical records.
  /// Called from BaseWidget's onModelReady
  Future<void> onInit() async {
    await _loadMedicalRecords();
  }

  /// Load medical records for the patient.
  Future<void> _loadMedicalRecords() async {
    setBusy(true);

    // Load all anamnesis and seguimientos from mock data
    _anamnesisRecords = anamnesis_data.anamnesisRecords;
    _allSeguimientos = seguimientos_data.seguimientoRecords;

    if (_anamnesisRecords.isEmpty) {
      setEmpty(empty: true);
    }

    setBusy(false);
  }

  /// Get seguimientos for a specific anamnesis
  List<SeguimientoRecord> getSeguimientosForAnamnesis(int anamnesisId) {
    return _allSeguimientos
        .where((seguimiento) => seguimiento.anamnesisId == anamnesisId)
        .toList();
  }

  /// Log anamnesis tap information.
  void logAnamnesisRecordTap(AnamnesisRecord record) {
    debugPrint(
      '🎯 Anamnesis clickeada - ID: ${record.id}, Fecha: ${record.date}, Estado: ${record.status}',
    );
    debugPrint('🎤 AudioPath: ${record.audioPath ?? "Sin audio"}');
  }

  /// Log seguimiento tap information.
  void logSeguimientoTap(SeguimientoRecord seguimiento) {
    debugPrint(
      '🎯 Seguimiento clickeado - ID: ${seguimiento.id}, Anamnesis ID: ${seguimiento.anamnesisId}',
    );
  }

  /// Handle navigation result from anamnesis session.
  void handleAnamnesisSessionResult(int anamnesisId, String? result) {
    debugPrint('🔙 Resultado recibido de Anamnesis: $result');
    if (result != null) {
      debugPrint('� Anamnesis $anamnesisId actualizada con estado: $result');
      // TODO: Update anamnesis status in list
      notifyListeners();
    }
  }

  /// Handle navigation result from seguimiento session.
  void handleSeguimientoSessionResult(int seguimientoId, String? result) {
    debugPrint('🔙 Resultado recibido de Seguimiento: $result');
    if (result != null) {
      debugPrint(
        '📝 Seguimiento $seguimientoId actualizado con estado: $result',
      );
      // TODO: Update seguimiento status in list
      notifyListeners();
    }
  }

  /// Handle result from new follow-up session.
  void handleNewFollowUpResult(String? result) {
    if (result != null) {
      debugPrint('📝 Nueva sesión de seguimiento creada con estado: $result');
    }
  }

  /// Create a new seguimiento record for an anamnesis
  int createNewSeguimiento({
    required int anamnesisId,
    required String consultationType,
  }) {
    debugPrint(
      '🆕 Creating new seguimiento for anamnesis $anamnesisId with type: $consultationType',
    );

    // Generate new ID (max current ID + 1)
    final int newId =
        _allSeguimientos.isEmpty
            ? 1
            : _allSeguimientos.map((s) => s.id).reduce((a, b) => a > b ? a : b) +
                1;

    // Get current date
    final now = DateTime.now();
    final String formattedDate =
        '${now.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(now.month)} ${now.year}';

    // Create new seguimiento record
    final newSeguimiento = SeguimientoRecord(
      id: newId,
      date: formattedDate,
      doctor: 'Dr. Pendiente',
      status: 'Pendiente',
      anamnesisId: anamnesisId,
      consultationType: consultationType,
    );

    // Add to list
    _allSeguimientos.add(newSeguimiento);

    // Update anamnesis seguimientos list
    final anamnesisIndex =
        _anamnesisRecords.indexWhere((a) => a.id == anamnesisId);
    if (anamnesisIndex != -1) {
      final anamnesis = _anamnesisRecords[anamnesisIndex];
      final updatedSeguimientos = [...anamnesis.seguimientosIds, newId];
      _anamnesisRecords[anamnesisIndex] = AnamnesisRecord(
        id: anamnesis.id,
        date: anamnesis.date,
        description: anamnesis.description,
        doctor: anamnesis.doctor,
        status: anamnesis.status,
        seguimientosIds: updatedSeguimientos,
        audioPath: anamnesis.audioPath,
      );
    }

    debugPrint('✅ Seguimiento $newId created successfully');
    notifyListeners();
    return newId;
  }

  /// Handle result from new anamnesis session.
  void handleNewAnamnesisResult(String? result) {
    if (result != null) {
      debugPrint('📝 Nueva sesión de anamnesis creada con estado: $result');
    }
  }

  /// Create a new anamnesis record with audio recording.
  void createAnamnesisWithAudio({required String audioPath}) {
    debugPrint('🎤 createAnamnesisWithAudio called with path: $audioPath');

    // Generate new ID (max current ID + 1)
    final int newId =
        _anamnesisRecords.isEmpty
            ? 1
            : _anamnesisRecords
                    .map((a) => a.id)
                    .reduce((a, b) => a > b ? a : b) +
                1;

    // Get current date
    final now = DateTime.now();
    final String formattedDate =
        '${now.day.toString().padLeft(2, '0')} ${_getMonthAbbreviation(now.month)} ${now.year}';

    // Create new anamnesis record
    final newAnamnesis = AnamnesisRecord(
      id: newId,
      date: formattedDate,
      description: 'Consulta con grabación de audio',
      doctor: 'Dr. Pendiente', // Can be updated later in the editor
      status: 'Pendiente',
      seguimientosIds: [],
      audioPath: audioPath,
    );

    debugPrint('📋 New anamnesis created:');
    debugPrint('   - ID: $newId');
    debugPrint('   - Date: $formattedDate');
    debugPrint('   - AudioPath: $audioPath');

    // Add to beginning of list (most recent first)
    _anamnesisRecords = [newAnamnesis, ..._anamnesisRecords];

    if (_anamnesisRecords.isNotEmpty) {
      setEmpty(empty: false);
    }

    notifyListeners();
    debugPrint('✅ Nueva anamnesis creada con audio - ID: $newId');
    debugPrint('🎤 Audio path: $audioPath');
  }

  /// Get abbreviated month name in Spanish
  String _getMonthAbbreviation(int month) {
    const months = [
      'Ene',
      'Feb',
      'Mar',
      'Abr',
      'May',
      'Jun',
      'Jul',
      'Ago',
      'Sep',
      'Oct',
      'Nov',
      'Dic',
    ];
    return months[month - 1];
  }
}
