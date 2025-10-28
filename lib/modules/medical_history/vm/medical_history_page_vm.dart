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


  List<MedicalRecord> get medicalRecords => _medicalRecords;

 
  set medicalRecords(List<MedicalRecord> value) {
    _medicalRecords = value;
    notifyListeners();
  }

  MedicalHistoryPageViewModel({required this.patient});

 
  Future<void> onInit() async {
    await _loadMedicalRecords();
  }


  Future<void> _loadMedicalRecords() async {
    setBusy(true);
    
    medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(patient.id);
    
    if (medicalRecords.isEmpty) {
      setEmpty(empty: true);
    }
    
    setBusy(false);
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


  void addNewRecord(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agregar nueva historia clínica para ${patient.name}'),
        backgroundColor: Colors.teal[600],
      ),
    );
  }
}
