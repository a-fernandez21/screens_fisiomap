import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import '../../../models/patient.dart';
import '../../../data/patients_data.dart';
import '../../patient_detail/page/patient_detail_page.dart';

/// Filter types for patient list
enum PatientFilterType {
  alphabeticalAZ,
  alphabeticalZA,
  lastVisitNewest,
  lastVisitOldest,
  genderMale,
  genderFemale,
}

/// ViewModel for Patient List screen.
///
/// Manages:
/// - Patient list state
/// - Data loading
/// - Navigation to detail screens
/// - Add patient events
/// - Multiple filter functionality
class PatientListPageViewModel extends BaseVM {
  // Private state variables
  List<Patient> _patients = [];
  List<Patient> _originalPatients = [];
  Set<PatientFilterType> _activeFilters = {};

  // Getters for state access
  List<Patient> get patients => _patients;
  bool get hasPatients => _patients.isNotEmpty;
  int get patientCount => _patients.length;
  Set<PatientFilterType> get activeFilters => _activeFilters;
  bool get hasActiveFilters => _activeFilters.isNotEmpty;

  // Setters with notifyListeners
  set patients(List<Patient> value) {
    _patients = value;
    notifyListeners();
  }

  set activeFilters(Set<PatientFilterType> value) {
    _activeFilters = value;
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

  /// Toggle a filter on/off.
  void toggleFilter(PatientFilterType filterType) {
    final Set<PatientFilterType> newFilters = Set.from(_activeFilters);
    
    // Handle mutually exclusive filters
    switch (filterType) {
      case PatientFilterType.alphabeticalAZ:
        newFilters.remove(PatientFilterType.alphabeticalZA);
        break;
      case PatientFilterType.alphabeticalZA:
        newFilters.remove(PatientFilterType.alphabeticalAZ);
        break;
      case PatientFilterType.lastVisitNewest:
        newFilters.remove(PatientFilterType.lastVisitOldest);
        break;
      case PatientFilterType.lastVisitOldest:
        newFilters.remove(PatientFilterType.lastVisitNewest);
        break;
      case PatientFilterType.genderMale:
        newFilters.remove(PatientFilterType.genderFemale);
        break;
      case PatientFilterType.genderFemale:
        newFilters.remove(PatientFilterType.genderMale);
        break;
    }
    
    // Toggle the selected filter
    if (newFilters.contains(filterType)) {
      newFilters.remove(filterType);
    } else {
      newFilters.add(filterType);
    }
    
    activeFilters = newFilters;
  }

  /// Clear all active filters.
  void clearAllFilters() {
    activeFilters = {};
    patients = List.from(_originalPatients);
    setEmpty(empty: patients.isEmpty);
  }

  /// Apply all active filters to patient list.
  void applyFilters() {
    List<Patient> filteredList = List.from(_originalPatients);

    // Apply gender filters
    if (activeFilters.contains(PatientFilterType.genderMale)) {
      filteredList = filteredList
          .where((patient) => patient.gender == 'Masculino')
          .toList();
    } else if (activeFilters.contains(PatientFilterType.genderFemale)) {
      filteredList = filteredList
          .where((patient) => patient.gender == 'Femenino')
          .toList();
    }

    // Apply sorting filters
    if (activeFilters.contains(PatientFilterType.alphabeticalAZ)) {
      filteredList.sort((a, b) => a.name.compareTo(b.name));
    } else if (activeFilters.contains(PatientFilterType.alphabeticalZA)) {
      filteredList.sort((a, b) => b.name.compareTo(a.name));
    }

    if (activeFilters.contains(PatientFilterType.lastVisitNewest)) {
      filteredList.sort((a, b) {
        final DateTime dateA = _parseDate(a.lastVisit);
        final DateTime dateB = _parseDate(b.lastVisit);
        return dateB.compareTo(dateA); // Most recent first
      });
    } else if (activeFilters.contains(PatientFilterType.lastVisitOldest)) {
      filteredList.sort((a, b) {
        final DateTime dateA = _parseDate(a.lastVisit);
        final DateTime dateB = _parseDate(b.lastVisit);
        return dateA.compareTo(dateB); // Oldest first
      });
    }

    patients = filteredList;
    setEmpty(empty: patients.isEmpty);
  }

  /// Parse date string in format "DD/MM/YYYY".
  DateTime _parseDate(String dateString) {
    final List<String> parts = dateString.split('/');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }

  /// Refresh the patient list (prepared for pull-to-refresh).
  Future<void> refreshPatients() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    await _loadPatients();
  }
}
