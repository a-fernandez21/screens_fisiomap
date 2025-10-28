import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../data/patients_data.dart';
import '../../patient_detail/page/patient_detail_page.dart';

/// ViewModel para la pantalla de lista de pacientes.
///
/// Gestiona toda la lógica de negocio separada de la vista:
/// - Estado de la lista de pacientes
/// - Carga de datos
/// - Navegación a pantallas
/// - Manejo de eventos (agregar paciente, etc.)
class PatientListPageViewModel extends BaseVM {
  // Private state variables
  List<Patient> _patients = [];

  // Getters for state access
  List<Patient> get patients => _patients;
  bool get hasPatients => _patients.isNotEmpty;
  int get patientCount => _patients.length;

  // Setters with notifyListeners
  set patients(List<Patient> value) {
    _patients = value;
    notifyListeners();
  }

  /// Initialize and load patients data.
  /// Called from BaseWidget's onModelReady
  Future<void> onInit() async {
    await _loadPatients();
  }

  /// Loads the list of patients from data source.
  Future<void> _loadPatients() async {
    setBusy(true);

    // Load data (currently from static data)
    patients = PatientsData.samplePatients;

    // Set empty state if no patients
    if (patients.isEmpty) {
      setEmpty(empty: true);
    }

    setBusy(false);
  }

  /// Navigates to patient detail screen.
  ///
  /// [context] - BuildContext for navigation
  /// [patient] - Selected patient
  void navigateToPatientDetail(BuildContext context, Patient patient) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientDetailPage(patient: patient),
      ),
    );
  }

  /// Handles add new patient event.
  ///
  /// Currently shows a SnackBar for pending functionality.
  void addNewPatient(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de agregar paciente próximamente'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  /// Filters patients by name (prepared for future search).
  ///
  /// [query] - Search text
  void filterPatients(String query) {
    if (query.isEmpty) {
      patients = PatientsData.samplePatients;
    } else {
      patients = PatientsData.samplePatients
          .where(
            (patient) =>
                patient.name.toLowerCase().contains(query.toLowerCase()),
          )
          .toList();
    }
    
    if (patients.isEmpty) {
      setEmpty(empty: true);
    }
  }

  /// Refreshes the patient list (prepared for pull-to-refresh).
  Future<void> refreshPatients() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadPatients();
  }
}
