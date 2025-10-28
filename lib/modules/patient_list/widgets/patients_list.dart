import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import 'patient_card.dart';

/// Scrollable list widget rendering all patient cards
class PatientsListWidget extends StatelessWidget {
  final List<Patient> patients;
  final Function(Patient) onPatientTap;
  final String? searchQuery;

  const PatientsListWidget({
    super.key,
    required this.patients,
    required this.onPatientTap,
    this.searchQuery,
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
              searchQuery: searchQuery,
            ),
          );
        },
      ),
    );
  }
}
