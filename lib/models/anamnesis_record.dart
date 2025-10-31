import 'package:flutter/material.dart';

/// Model representing an Anamnesis record (initial clinical assessment)
class AnamnesisRecord {
  /// Unique identifier
  final int id;

  /// Date in String format
  final String date;

  /// Brief description of consultation reason or diagnosis
  final String description;

  /// Professional's name who attended
  final String doctor;

  /// Treatment status (Revisado, Pendiente)
  final String status;

  /// List of seguimiento IDs associated with this anamnesis
  final List<int> seguimientosIds;

  /// Optional audio file path from voice recording
  final String? audioPath;

  AnamnesisRecord({
    required this.id,
    required this.date,
    required this.description,
    required this.doctor,
    required this.status,
    required this.seguimientosIds,
    this.audioPath,
  });

  IconData get typeIcon {
    return Icons.assignment;
  }
}
