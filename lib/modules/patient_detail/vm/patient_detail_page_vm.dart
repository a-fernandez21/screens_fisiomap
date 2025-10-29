import 'package:flutter/foundation.dart';
import 'package:pumpun_core/pumpun_core.dart';
import 'package:screens_fisiomap/models/patient.dart';
import 'package:screens_fisiomap/models/medical_record.dart';
import 'package:screens_fisiomap/data/medical_records_data.dart';

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
  List<MedicalRecord> _medicalRecords = [];

  // Getters for state access
  List<MedicalRecord> get medicalRecords => _medicalRecords;

  // Setters with notifyListeners
  set medicalRecords(List<MedicalRecord> value) {
    _medicalRecords = value;
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

    medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(patient.id);

    if (medicalRecords.isEmpty) {
      setEmpty(empty: true);
    }

    setBusy(false);
  }

  /// Update status of a medical record.
  void updateRecordStatus(int recordId, String newStatus) {
    debugPrint('🔄 Actualizando estado del registro $recordId a: $newStatus');
    final int index = _medicalRecords.indexWhere((r) => r.id == recordId);
    debugPrint('📍 Índice encontrado: $index');

    if (index != -1) {
      debugPrint('✅ Estado anterior: ${_medicalRecords[index].status}');
      _medicalRecords[index] = _medicalRecords[index].copyWith(
        status: newStatus,
      );
      debugPrint('✅ Estado nuevo: ${_medicalRecords[index].status}');
      notifyListeners();
    } else {
      debugPrint('❌ No se encontró el registro con ID: $recordId');
    }
  }

  /// Log record tap information.
  void logRecordTap(MedicalRecord record) {
    debugPrint(
      '🎯 Tarjeta clickeada - ID: ${record.id}, Tipo: ${record.type}, Estado actual: ${record.status}',
    );
  }

  /// Handle navigation result from record session.
  void handleRecordSessionResult(int recordId, String? result) {
    debugPrint('🔙 Resultado recibido de RecordSessionPage: $result');
    if (result != null) {
      debugPrint(
        '📤 Llamando a updateRecordStatus con ID: $recordId y estado: $result',
      );
      updateRecordStatus(recordId, result);
    } else {
      debugPrint('⚠️ El resultado es null, no se actualiza el estado');
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
