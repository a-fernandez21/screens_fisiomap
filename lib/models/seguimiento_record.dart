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

  /// Tipo de consulta (Teléfono, Presencial, Videollamada).
  final String? consultationType;

  SeguimientoRecord({
    required this.id,
    required this.date,
    required this.doctor,
    required this.status,
    required this.anamnesisId,
    this.consultationType,
  });

  IconData get typeIcon {
    return Icons.trending_up;
  }

  /// Get icon for consultation type
  IconData get consultationTypeIcon {
    switch (consultationType) {
      case 'Teléfono':
        return Icons.phone;
      case 'Presencial':
        return Icons.person;
      case 'Videollamada':
        return Icons.videocam;
      default:
        return Icons.help_outline;
    }
  }

  /// Get color for consultation type
  Color get consultationTypeColor {
    switch (consultationType) {
      case 'Teléfono':
        return Colors.blue;
      case 'Presencial':
        return Colors.green;
      case 'Videollamada':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
