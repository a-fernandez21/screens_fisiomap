import 'package:flutter/material.dart';
import '../../../models/patient.dart';

/// Widget that displays the patient's circular avatar.
///
/// Shows the patient's initials in a colored CircleAvatar.
class PatientAvatarWidget extends StatelessWidget {
  final Patient patient;

  const PatientAvatarWidget({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.teal[100],
      child: Text(
        patient.initials,
        style: TextStyle(
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}