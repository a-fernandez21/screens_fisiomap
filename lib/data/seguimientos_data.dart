import 'package:screens_fisiomap/models/seguimiento_record.dart';

/// Mock data for seguimiento records
final List<SeguimientoRecord> seguimientoRecords = [
  // Seguimientos para Anamnesis ID 1 (dolor lumbar crónico)
  SeguimientoRecord(
    id: 1,
    date: '18 Oct 2025',
    doctor: 'Dra. María García',
    status: 'Completado',
    anamnesisId: 1,
  ),
  SeguimientoRecord(
    id: 2,
    date: '20 Oct 2025',
    doctor: 'Dra. María García',
    status: 'Completado',
    anamnesisId: 1,
  ),
  SeguimientoRecord(
    id: 3,
    date: '25 Oct 2025',
    doctor: 'Dra. María García',
    status: 'Completado',
    anamnesisId: 1,
  ),

  // Seguimientos para Anamnesis ID 2 (lesión en hombro)
  SeguimientoRecord(
    id: 4,
    date: '10 Oct 2025',
    doctor: 'Dr. Carlos Ruiz',
    status: 'Completado',
    anamnesisId: 2,
  ),
  SeguimientoRecord(
    id: 5,
    date: '15 Oct 2025',
    doctor: 'Dr. Carlos Ruiz',
    status: 'Completado',
    anamnesisId: 2,
  ),

  // Seguimientos para Anamnesis ID 3 (contractura cervical)
  SeguimientoRecord(
    id: 6,
    date: '05 Oct 2025',
    doctor: 'Dra. Ana Martínez',
    status: 'Pendiente',
    anamnesisId: 3,
  ),

  // Seguimientos para Anamnesis ID 4 (postoperatorio rodilla)
  SeguimientoRecord(
    id: 7,
    date: '25 Sep 2025',
    doctor: 'Dr. Jorge López',
    status: 'Completado',
    anamnesisId: 4,
  ),
  SeguimientoRecord(
    id: 8,
    date: '02 Oct 2025',
    doctor: 'Dr. Jorge López',
    status: 'Completado',
    anamnesisId: 4,
  ),
  SeguimientoRecord(
    id: 9,
    date: '09 Oct 2025',
    doctor: 'Dr. Jorge López',
    status: 'Completado',
    anamnesisId: 4,
  ),
  SeguimientoRecord(
    id: 10,
    date: '16 Oct 2025',
    doctor: 'Dr. Jorge López',
    status: 'Completado',
    anamnesisId: 4,
  ),

  // Seguimientos para Anamnesis ID 5 (tendinitis de Aquiles)
  SeguimientoRecord(
    id: 11,
    date: '18 Sep 2025',
    doctor: 'Dra. Laura Sánchez',
    status: 'Completado',
    anamnesisId: 5,
  ),
];
