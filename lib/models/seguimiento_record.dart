import 'package:flutter/material.dart';

class SeguimientoRecord {
  /// Identificador único de la historia clínica.
  final int id;

  /// Fecha de la consulta en formato String.
  final String date;

  /// Nombre del profesional que atendió la consulta.
  final String doctor;

  /// Estado del tratamiento (Revisado, Pendiente).
  final String status;

  /// ID de la anamnesis asociada a este seguimiento.
  final int anamnesisId;

  SeguimientoRecord({
    required this.id,
    required this.date,
    required this.doctor,
    required this.status,
    required this.anamnesisId,
  });

  IconData get typeIcon {
    return Icons.trending_up;
  }
}
