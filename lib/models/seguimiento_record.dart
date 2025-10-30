import 'package:flutter/material.dart';

/// Model representing a Seguimiento record (follow-up session)
class SeguimientoRecord {
  /// Unique identifier
  final int id;

  /// Date in String format
  final String date;

  /// Brief description of the follow-up
  final String description;

  /// Professional's name who attended
  final String doctor;

  /// Treatment status (Completado, Pendiente)
  final String status;
  
  /// ID of the anamnesis this seguimiento belongs to
  final int anamnesisId;

  SeguimientoRecord({
    required this.id,
    required this.date,
    required this.description,
    required this.doctor,
    required this.status,
    required this.anamnesisId,
  });

  IconData get typeIcon {
    return Icons.trending_up;
  }
}
