import 'package:flutter/material.dart';

/// Modelo de datos que representa una historia clínica.
///
/// Contiene la información de una consulta o visita médica del paciente.
class MedicalRecord {
  /// Identificador único de la historia clínica.
  final int id;

  /// Fecha de la consulta en formato String.
  final String date;

  /// Tipo de consulta (Anamnesis, Seguimiento, Revisión, etc.).
  final String type;

  /// Descripción breve del motivo de consulta o diagnóstico.
  final String description;

  /// Nombre del profesional que atendió la consulta.
  final String doctor;

  /// Estado del tratamiento (En curso, Completado, Pendiente).
  final String status;

  /// Constructor para crear una instancia de [MedicalRecord].
  const MedicalRecord({
    required this.id,
    required this.date,
    required this.type,
    required this.description,
    required this.doctor,
    required this.status,
  });

  /// Crea una copia del registro con los campos especificados modificados.
  MedicalRecord copyWith({
    int? id,
    String? date,
    String? type,
    String? description,
    String? doctor,
    String? status,
  }) {
    return MedicalRecord(
      id: id ?? this.id,
      date: date ?? this.date,
      type: type ?? this.type,
      description: description ?? this.description,
      doctor: doctor ?? this.doctor,
      status: status ?? this.status,
    );
  }

  /// Obtiene el color asociado al tipo de consulta.
  Color get typeColor {
    switch (type.toLowerCase()) {
      case 'anamnesis':
        return const Color(0xFF2196F3); // Azul
      case 'seguimiento':
        return const Color(0xFF4CAF50); // Verde
      case 'revisión':
        return const Color(0xFFFF9800); // Naranja
      case 'urgencia':
        return const Color(0xFFF44336); // Rojo
      default:
        return const Color(0xFF607D8B); // Gris azulado
    }
  }

  /// Obtiene el icono asociado al tipo de consulta.
  IconData get typeIcon {
    switch (type.toLowerCase()) {
      case 'anamnesis':
        return Icons.assignment;
      case 'seguimiento':
        return Icons.trending_up;
      case 'revisión':
        return Icons.visibility;
      case 'urgencia':
        return Icons.emergency;
      default:
        return Icons.medical_services;
    }
  }

  /// Obtiene el color asociado al estado del tratamiento.
  Color get statusColor {
    switch (status.toLowerCase()) {
      case 'completado':
        return const Color(0xFF4CAF50); // Verde
      case 'en curso':
        return const Color(0xFF2196F3); // Azul
      case 'pendiente':
        return const Color(0xFFFF9800); // Naranja
      default:
        return const Color(0xFF757575); // Gris
    }
  }
}
