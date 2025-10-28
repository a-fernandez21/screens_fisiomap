import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import 'patient_avatar.dart';
import 'patient_arrow.dart';
import 'patient_info.dart';

/// Patient card widget displaying individual patient information
///
/// Shows patient data in a card format with avatar, name, last visit, and arrow indicator
class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;
  final String? searchQuery;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
    this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              PatientAvatarWidget(patient: patient),
              const SizedBox(width: 16),
              PatientInfoWidget(
                patient: patient,
                searchQuery: searchQuery,
              ),
              const ArrowIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
