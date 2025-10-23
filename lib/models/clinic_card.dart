import 'package:flutter/material.dart';
import 'package:screens_fisiomap/enums/clinic_types.dart';

class ClinicCard {
  int id;
  ClinicType type;
  Icon icon;
  DateTime date;
  int patientId;
  int doctorId;
  String patientName;
  String doctorName;

  ClinicCard({
    required this.id,
    required this.type,
    required this.date,
    required this.patientId,
    required this.doctorId,
    required this.patientName,
    required this.doctorName,
  }) : icon = type == ClinicType.anamnesis
      ? const Icon(Icons.assignment)
      : const Icon(Icons.trending_up);

}