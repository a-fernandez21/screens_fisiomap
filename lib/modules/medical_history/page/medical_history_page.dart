import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/medical_history_page_vm.dart';
import '../widgets/medical_history_widgets.dart';
import '../../../models/patient.dart';

/// Medical History Page displaying patient's medical records.
///
/// MVVM Architecture:
/// - VIEW: This file (UI composition only)
/// - LOGIC: MedicalHistoryPageViewModel (vm/)
/// - WIDGETS: Reusable components (widgets/)
///
/// This page provides a comprehensive view of a patient's medical history
/// including summary information, list of medical records, and functionality
/// to add new records.
///
/// Features:
/// - Patient summary card with key information
/// - Scrollable list of medical records
/// - Empty state when no records exist
/// - Loading indicator during data fetch
/// - Floating action button to add new records
/// - Navigation to individual record sessions
class MedicalHistoryPage extends StatelessWidget {
  /// The patient whose medical history is being displayed.
  final Patient patient;

  /// Creates a MedicalHistoryPage.
  ///
  /// [patient] is required and represents the patient whose medical
  /// history will be displayed in this page.
  const MedicalHistoryPage({super.key, required this.patient});

  /// Builds the medical history page UI.
  ///
  /// Uses BaseWidget pattern to wrap the ViewModel and provide reactive UI.
  /// The page structure includes:
  /// - AppBar with patient name
  /// - Patient summary section
  /// - Medical records section with title and count
  /// - Conditional rendering based on state (loading, empty, or list)
  /// - Floating action button for adding new records
  @override
  Widget build(BuildContext context) {
    return BaseWidget<MedicalHistoryPageViewModel>(
      // Initialize ViewModel with patient data
      model: MedicalHistoryPageViewModel(patient: patient),
      // Setup ViewModel when ready
      onModelReady: (model) => model.initialize(),
      // Build UI based on ViewModel state
      builder:
          (context, model, child) => Scaffold(
            backgroundColor: Colors.grey[50],
            // AppBar showing patient's name
            appBar: MedicalHistoryAppBar(patientName: model.patient.name),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  // Patient summary card with basic information
                  PatientSummaryWidget(patient: model.patient),
                  const SizedBox(height: 24),
                  // Section header with records count
                  SectionTitleWidget(
                    title: 'Historial Clínico',
                    subtitle: '${model.medicalRecords.length} registros',
                  ),
                  const SizedBox(height: 16),
                  // Conditional content based on ViewModel state
                  if (model.busy)
                    // Show loading indicator when fetching data
                    const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (model.isEmpty)
                    // Show empty state when no records exist
                    const Expanded(child: EmptyMedicalRecordsWidget())
                  else
                    // Show scrollable list of medical records
                    MedicalRecordsListWidget(
                      medicalRecords: model.medicalRecords,
                      onRecordTap:
                          (record) => model.onRecordTap(context, record),
                    ),
                ],
              ),
            ),
            // Floating action button for adding new medical records
            floatingActionButton: AddRecordFAB(
              onPressed: () => model.addNewRecord(context),
            ),
          ),
    );
  }
}
