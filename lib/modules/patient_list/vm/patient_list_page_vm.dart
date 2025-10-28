import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../data/patients_data.dart';
import '../../patient_detail/page/patient_detail_page.dart';

/// Filter types for patient list
enum PatientFilterType {
  none,
  alphabetical,
  lastVisit,
  gender,
}

/// ViewModel for Patient List screen.
///
/// Manages:
/// - Patient list state
/// - Data loading
/// - Navigation to detail screens
/// - Add patient events
/// - Filter functionality
class PatientListPageViewModel extends BaseVM {
  // Private state variables
  List<Patient> _patients = [];
  List<Patient> _originalPatients = [];
  PatientFilterType _currentFilter = PatientFilterType.none;
  String? _selectedGender;

  // Getters for state access
  List<Patient> get patients => _patients;
  bool get hasPatients => _patients.isNotEmpty;
  int get patientCount => _patients.length;
  PatientFilterType get currentFilter => _currentFilter;
  String? get selectedGender => _selectedGender;

  // Setters with notifyListeners
  set patients(List<Patient> value) {
    _patients = value;
    notifyListeners();
  }

  set currentFilter(PatientFilterType value) {
    _currentFilter = value;
    notifyListeners();
  }

  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  /// Initialize and load patients data.
  /// Called from BaseWidget's onModelReady
  Future<void> onInit() async {
    await _loadPatients();
  }

  /// Load the list of patients from data source.
  Future<void> _loadPatients() async {
    setBusy(true);

    // Load data (currently from static data)
    _originalPatients = PatientsData.samplePatients;
    patients = List.from(_originalPatients);

    // Set empty state if no patients
    if (patients.isEmpty) {
      setEmpty(empty: true);
    }

    setBusy(false);
  }

  /// Navigate to patient detail screen.
  void navigateToPatientDetail(BuildContext context, Patient patient) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientDetailPage(patient: patient),
      ),
    );
  }

  /// Handle filter selection from menu.
  Future<void> onFilterSelected(
    PatientFilterType filterType,
    BuildContext context,
  ) async {
    if (filterType == PatientFilterType.gender) {
      await _showGenderFilterDialog(context);
    } else {
      applyFilter(filterType);
    }
  }

  /// Show gender selection dialog.
  Future<void> _showGenderFilterDialog(BuildContext context) async {
    final String? gender = await showDialog<String>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar sexo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Masculino'),
              onTap: () => Navigator.pop(context, 'Masculino'),
            ),
            ListTile(
              title: const Text('Femenino'),
              onTap: () => Navigator.pop(context, 'Femenino'),
            ),
          ],
        ),
      ),
    );

    if (gender != null) {
      selectedGender = gender;
      applyFilter(PatientFilterType.gender);
    }
  }

  /// Apply selected filter to patient list.
  void applyFilter(PatientFilterType filterType) {
    currentFilter = filterType;
    List<Patient> filteredList = List.from(_originalPatients);

    switch (filterType) {
      case PatientFilterType.none:
        patients = filteredList;
        selectedGender = null;
        break;

      case PatientFilterType.alphabetical:
        filteredList.sort((a, b) => a.name.compareTo(b.name));
        patients = filteredList;
        break;

      case PatientFilterType.lastVisit:
        filteredList.sort((a, b) {
          // Parse dates in format "DD/MM/YYYY"
          final List<String> datePartsA = a.lastVisit.split('/');
          final List<String> datePartsB = b.lastVisit.split('/');
          
          final DateTime dateA = DateTime(
            int.parse(datePartsA[2]),
            int.parse(datePartsA[1]),
            int.parse(datePartsA[0]),
          );
          final DateTime dateB = DateTime(
            int.parse(datePartsB[2]),
            int.parse(datePartsB[1]),
            int.parse(datePartsB[0]),
          );
          
          return dateB.compareTo(dateA); // Most recent first
        });
        patients = filteredList;
        break;

      case PatientFilterType.gender:
        if (selectedGender != null) {
          filteredList = filteredList
              .where((patient) => patient.gender == selectedGender)
              .toList();
        }
        patients = filteredList;
        break;
    }

    if (patients.isEmpty) {
      setEmpty(empty: true);
    } else {
      setEmpty(empty: false);
    }
  }

  /// Filter patients by name (prepared for future search).
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

  /// Refresh the patient list (prepared for pull-to-refresh).
  Future<void> refreshPatients() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadPatients();
  }
}
