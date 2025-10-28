import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../models/medical_record.dart';
import '../../../data/medical_records_data.dart';
import '../../record_session/page/record_session_page.dart';

/// ViewModel for Patient Detail screen.
///
/// Manages:
/// - Loading medical records for a patient
/// - Updating record status (Pendiente/Completado)
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

  /// Handle tap on a medical record card.
  Future<void> onRecordTap(BuildContext context, MedicalRecord record) async {
    debugPrint(
      '🎯 Tarjeta clickeada - ID: ${record.id}, Tipo: ${record.type}, Estado actual: ${record.status}',
    );

    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => RecordSessionPage(
          patient: patient,
          sessionType: record.type,
          recordId: record.id,
        ),
      ),
    );

    debugPrint('🔙 Resultado recibido de RecordSessionPage: $result');
    if (result != null) {
      debugPrint(
        '📤 Llamando a updateRecordStatus con ID: ${record.id} y estado: $result',
      );
      updateRecordStatus(record.id, result);
    } else {
      debugPrint('⚠️ El resultado es null, no se actualiza el estado');
    }
  }

  /// Navigate to new follow-up session.
  Future<void> onNewFollowUp(BuildContext context) async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => RecordSessionPage(
          patient: patient,
          sessionType: 'Seguimiento',
        ),
      ),
    );

    // For new sessions, could create a new record
    if (result != null) {
      debugPrint('📝 Nueva sesión de seguimiento creada con estado: $result');
    }
  }

  /// Navigate to new anamnesis session.
  Future<void> onNewAnamnesis(BuildContext context) async {
    final String? result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder: (context) => RecordSessionPage(
          patient: patient,
          sessionType: 'Anamnesis',
        ),
      ),
    );

    // For new sessions, could create a new record
    if (result != null) {
      debugPrint('📝 Nueva sesión de anamnesis creada con estado: $result');
    }
  }
}
