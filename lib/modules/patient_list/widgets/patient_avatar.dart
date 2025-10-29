import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/patient.dart';

/// Circular avatar displaying patient's initials
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
