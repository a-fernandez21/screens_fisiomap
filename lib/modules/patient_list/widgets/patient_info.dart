import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import 'patient_name.dart';
import 'patient_date.dart';

/// Container grouping patient's name and last visit information
class PatientInfoWidget extends StatelessWidget {
  final Patient patient;

  const PatientInfoWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PatientNameWidget(name: patient.name),
          const SizedBox(height: 4),
          PatientLastVisitWidget(lastVisit: patient.lastVisit),
        ],
      ),
    );
  }
}
