import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../models/medical_record.dart';
import '../../../data/medical_records_data.dart';

/// ViewModel for Medical History screen.
///
/// Manages:
/// - Loading medical records for a patient
/// - Handling record tap events
/// - Adding new records
class MedicalHistoryPageViewModel extends BaseVM {
  final Patient patient;
  List<MedicalRecord> _medicalRecords = [];

  MedicalHistoryPageViewModel({required this.patient});

  List<MedicalRecord> get medicalRecords => _medicalRecords;

  /// Initialize ViewModel and load medical records.
  void initialize() {
    loadMedicalRecords();
  }

  /// Load medical records for the patient.
  void loadMedicalRecords() {
    setBusy(true);
    _medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(patient.id);
    
    if (_medicalRecords.isEmpty) {
      setEmpty(empty: true);
    }
    
    setBusy(false);
    notifyListeners();
  }

  /// Handle tap on a medical record card.
  void onRecordTap(BuildContext context, MedicalRecord record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registro ${record.type} - ${record.date}'),
        backgroundColor: record.typeColor,
      ),
    );
  }

  /// Handle adding a new medical record.
  void addNewRecord(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agregar nueva historia clínica para ${patient.name}'),
        backgroundColor: Colors.teal[600],
      ),
    );
  }
}
