import 'package:screens_fisiomap/models/anamnesis_record.dart';

/// Mock data for anamnesis records
final List<AnamnesisRecord> anamnesisRecords = [
  AnamnesisRecord(
    id: 1,
    date: '15 Oct 2025',
    description: 'Primera consulta por dolor lumbar crónico',
    doctor: 'Dra. María García',
    status: 'Revisado',
    seguimientosIds: [1, 2, 3],
  ),
  AnamnesisRecord(
    id: 2,
    date: '08 Oct 2025',
    description: 'Evaluación de lesión en hombro derecho',
    doctor: 'Dr. Carlos Ruiz',
    status: 'Revisado',
    seguimientosIds: [4, 5],
  ),
  AnamnesisRecord(
    id: 3,
    date: '01 Oct 2025',
    description: 'Consulta por contractura cervical',
    doctor: 'Dra. Ana Martínez',
    status: 'Pendiente',
    seguimientosIds: [6],
  ),
  AnamnesisRecord(
    id: 4,
    date: '22 Sep 2025',
    description: 'Evaluación postoperatoria de rodilla',
    doctor: 'Dr. Jorge López',
    status: 'Revisado',
    seguimientosIds: [7, 8, 9, 10],
  ),
  AnamnesisRecord(
    id: 5,
    date: '15 Sep 2025',
    description: 'Primera consulta por tendinitis de Aquiles',
    doctor: 'Dra. Laura Sánchez',
    status: 'Revisado',
    seguimientosIds: [11],
  ),
];
