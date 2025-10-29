import 'package:pumpun_core/pumpun_core.dart';
import 'package:screens_fisiomap/models/patient.dart';
import 'package:screens_fisiomap/data/patients_data.dart';

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
  // Private state variables with their getters and setters
  List<Patient> _patients = [];
  List<Patient> get patients => _patients;
  set patients(List<Patient> value) {
    _patients = value;
    notifyListeners();
  }

  List<Patient> _originalPatients = [];

  Set<PatientFilterType> _activeFilters = {};
  Set<PatientFilterType> get activeFilters => _activeFilters;
  set activeFilters(Set<PatientFilterType> value) {
    _activeFilters = value;
    notifyListeners();
  }

  Set<PatientFilterType> _tempFilters = {};
  Set<PatientFilterType> get tempFilters => _tempFilters;
  set tempFilters(Set<PatientFilterType> value) {
    _tempFilters = value;
    notifyListeners();
  }

  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  // Computed getters
  bool get hasPatients => _patients.isNotEmpty;
  int get patientCount => _patients.length;
  bool get hasActiveFilters => _activeFilters.isNotEmpty;
  bool get hasTempFilters => _tempFilters.isNotEmpty;

  // Constructor
  PatientListPageViewModel();

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
    _applySearchAndFilters();
  }

  /// Initialize temp filters with current active filters.
  void initTempFilters() {
    _tempFilters = Set.from(_activeFilters);
    notifyListeners();
  }

  /// Toggle a temporary filter on/off (for filter sheet preview).
  void toggleTempFilter(PatientFilterType filterType) {
    final Set<PatientFilterType> newFilters = Set.from(_tempFilters);
    
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
    
    tempFilters = newFilters;
  }

  /// Clear all temporary filters.
  void clearAllTempFilters() {
    tempFilters = {};
  }

  /// Apply temporary filters to active filters.
  void applyTempFilters() {
    activeFilters = Set.from(_tempFilters);
    applyFilters();
  }

  /// Search patients by name, phone, or email.
  void searchPatients(String query) {
    _searchQuery = query;
    _applySearchAndFilters();
  }

  /// Apply search and filters together.
  void _applySearchAndFilters() {
    List<Patient> filteredList = List.from(_originalPatients);

    // Apply search filter first (even with single character)
    final String trimmedQuery = _searchQuery.trim();
    if (trimmedQuery.isNotEmpty) {
      final String lowerQuery = trimmedQuery.toLowerCase();
      
      // Filter patients that match the query ONLY in name
      filteredList = filteredList.where((patient) {
        final String lowerName = patient.name.toLowerCase();
        // Only search in name to ensure we can highlight matches
        return lowerName.contains(lowerQuery);
      }).toList();
      
      // Sort by position of match (earlier match = higher priority)
      filteredList.sort((a, b) {
        final String lowerNameA = a.name.toLowerCase();
        final String lowerNameB = b.name.toLowerCase();
        
        // Get position of match in name
        final int nameIndexA = lowerNameA.indexOf(lowerQuery);
        final int nameIndexB = lowerNameB.indexOf(lowerQuery);
        
        // Compare positions (earlier = higher priority)
        if (nameIndexA != nameIndexB) {
          return nameIndexA.compareTo(nameIndexB);
        }
        
        // Same position, alphabetical order
        return lowerNameA.compareTo(lowerNameB);
      });
    }

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

  /// Apply all active filters to patient list.
  void applyFilters() {
    _applySearchAndFilters();
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
