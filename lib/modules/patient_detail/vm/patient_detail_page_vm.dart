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

  /// Handle result from new anamnesis session.
  void handleNewAnamnesisResult(String? result) {
    if (result != null) {
      debugPrint('📝 Nueva sesión de anamnesis creada con estado: $result');
    }
  }
}
