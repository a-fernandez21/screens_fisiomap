import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/patient_list_page_vm.dart';
import '../widgets/patient_card.dart';
import '../../../models/patient.dart';

/// Main screen displaying FisioMap clinic patient list.
///
/// MVVM Architecture:
/// - VIEW: This file (UI/widgets only)
/// - LOGIC: PatientListPageViewModel (vm/)
/// - WIDGETS: PatientCard and components (widgets/)
///
/// Includes:
/// - AppBar with title
/// - Scrollable patient list
/// - Floating button to add patients
class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PatientListPageViewModel>(
      model: PatientListPageViewModel(),
      onModelReady: (model) => model.initialize(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: const _AppBarWidget(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const _SectionTitleWidget(title: 'Lista de Pacientes'),
              const SizedBox(height: 16),
              // Display loading or list based on state
              if (model.busy)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (model.isEmpty)
                const Expanded(
                  child: _EmptyStateWidget(),
                )
              else
                _PatientsListWidget(
                  patients: model.patients,
                  onPatientTap: (patient) =>
                      model.navigateToPatientDetail(context, patient),
                ),
            ],
          ),
        ),
        floatingActionButton: _AddPatientFAB(
          onPressed: () => model.addNewPatient(context),
        ),
      ),
    );
  }
}

/// AppBar widget for patient screen.
class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pacientes',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 45, 183, 221),
      elevation: 4,
      centerTitle: true,
    );
  }
}

/// Section title widget.
class _SectionTitleWidget extends StatelessWidget {
  final String title;

  const _SectionTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal[800],
      ),
    );
  }
}

/// Widget rendering the complete patient list.
class _PatientsListWidget extends StatelessWidget {
  final List<Patient> patients;
  final Function(Patient) onPatientTap;

  const _PatientsListWidget({
    required this.patients,
    required this.onPatientTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final Patient patient = patients[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: PatientCard(
              patient: patient,
              onTap: () => onPatientTap(patient),
            ),
          );
        },
      ),
    );
  }
}

/// Empty state widget when no patients.
class _EmptyStateWidget extends StatelessWidget {
  const _EmptyStateWidget();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No hay pacientes registrados',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}

/// Floating action button widget.
class _AddPatientFAB extends StatelessWidget {
  final VoidCallback onPressed;

  const _AddPatientFAB({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      child: const Icon(Icons.person_add),
    );
  }
}
