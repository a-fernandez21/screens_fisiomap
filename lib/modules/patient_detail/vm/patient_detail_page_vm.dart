import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../models/medical_record.dart';
import '../../../data/medical_records_data.dart';
import '../../../screens/record_session_screen.dart';

/// ViewModel for Patient Detail screen.
///
/// Manages:
/// - Loading medical records for a patient
/// - Updating record status (Pendiente/Completado)
/// - Handling record tap events
/// - Navigation to record session screen
class PatientDetailPageViewModel extends BaseVM {
  final Patient patient;
  List<MedicalRecord> _medicalRecords = [];

  PatientDetailPageViewModel({required this.patient});

  List<MedicalRecord> get medicalRecords => _medicalRecords;

  /// Initialize ViewModel and load medical records.
  void initialize() {
    loadMedicalRecords();
  }

  /// Load medical records for the patient.
  void loadMedicalRecords() {
    setBusy(true);
    _medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(
      patient.id,
    );

    if (_medicalRecords.isEmpty) {
      setEmpty(empty: true);
    }

    setBusy(false);
    notifyListeners();
  }

  /// Update status of a medical record.
  void updateRecordStatus(int recordId, String newStatus) {
    print('🔄 Actualizando estado del registro $recordId a: $newStatus');
    final index = _medicalRecords.indexWhere((r) => r.id == recordId);
    print('📍 Índice encontrado: $index');

    if (index != -1) {
      print('✅ Estado anterior: ${_medicalRecords[index].status}');
      _medicalRecords[index] = _medicalRecords[index].copyWith(
        status: newStatus,
      );
      print('✅ Estado nuevo: ${_medicalRecords[index].status}');
      notifyListeners();
    } else {
      print('❌ No se encontró el registro con ID: $recordId');
    }
  }

  /// Handle tap on a medical record card.
  void onRecordTap(BuildContext context, MedicalRecord record) async {
    print(
      '🎯 Tarjeta clickeada - ID: ${record.id}, Tipo: ${record.type}, Estado actual: ${record.status}',
    );

    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder:
            (context) => RecordSessionScreen(
              patient: patient,
              sessionType: record.type,
              recordId: record.id,
            ),
      ),
    );

    print('🔙 Resultado recibido de RecordSessionScreen: $result');
    if (result != null) {
      print(
        '📤 Llamando a updateRecordStatus con ID: ${record.id} y estado: $result',
      );
      updateRecordStatus(record.id, result);
    } else {
      print('⚠️ El resultado es null, no se actualiza el estado');
    }
  }

  /// Navigate to new follow-up session.
  void onNewFollowUp(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder:
            (context) => RecordSessionScreen(
              patient: patient,
              sessionType: 'Seguimiento',
            ),
      ),
    );

    // For new sessions, could create a new record
    if (result != null) {
      print('📝 Nueva sesión de seguimiento creada con estado: $result');
    }
  }

  /// Navigate to new anamnesis session.
  void onNewAnamnesis(BuildContext context) async {
    final result = await Navigator.push<String>(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                RecordSessionScreen(patient: patient, sessionType: 'Anamnesis'),
      ),
    );

    // For new sessions, could create a new record
    if (result != null) {
      print('📝 Nueva sesión de anamnesis creada con estado: $result');
    }
  }
}
