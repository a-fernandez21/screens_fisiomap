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

  // Private state variables
  List<MedicalRecord> _medicalRecords = [];

  // Getters for state access
  List<MedicalRecord> get medicalRecords => _medicalRecords;

  // Setters with notifyListeners
  set medicalRecords(List<MedicalRecord> value) {
    _medicalRecords = value;
    notifyListeners();
  }

  MedicalHistoryPageViewModel({required this.patient});

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

  /// Get record info for displaying in view.
  /// Returns a map with type, date and color.
  Map<String, dynamic> getRecordInfo(MedicalRecord record) {
    return {
      'type': record.type,
      'date': record.date,
      'color': record.typeColor,
    };
  }

  /// Get patient name for new record message.
  String getPatientName() {
    return patient.name;
  }
}
