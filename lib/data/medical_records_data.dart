import '../models/medical_record.dart';

/// Clase que contiene datos de ejemplo para historias clínicas.
///
/// Esta es una clase utilitaria que proporciona una lista estática de historias clínicas
/// para propósitos de prueba y demostración. En una aplicación real, estos datos
/// provendrían de una base de datos o API.
class MedicalRecordsData {
  /// Constructor privado para prevenir la instanciación.
  MedicalRecordsData._();

  /// Lista de historias clínicas de ejemplo con datos de prueba.
  ///
  /// Contiene diferentes tipos de consultas con sus respectivos datos.
  static const List<MedicalRecord> sampleMedicalRecords = [
    MedicalRecord(
      id: 1,
      date: '22/10/2024',
      type: 'Anamnesis',
      description: 'Primera consulta - Dolor lumbar crónico',
      doctor: 'Dr. García Martínez',
      status: 'Completado',
    ),
    MedicalRecord(
      id: 2,
      date: '20/10/2024',
      type: 'Seguimiento',
      description: 'Evolución del tratamiento de rehabilitación',
      doctor: 'Dra. López Fernández',
      status: 'En curso',
    ),
    MedicalRecord(
      id: 3,
      date: '18/10/2024',
      type: 'Revisión',
      description: 'Control post-operatorio de rodilla izquierda',
      doctor: 'Dr. Ruiz Santos',
      status: 'Completado',
    ),
    MedicalRecord(
      id: 4,
      date: '15/10/2024',
      type: 'Anamnesis',
      description: 'Evaluación de lesión deportiva - Hombro derecho',
      doctor: 'Dra. Moreno Castro',
      status: 'Completado',
    ),
    MedicalRecord(
      id: 5,
      date: '12/10/2024',
      type: 'Seguimiento',
      description: 'Sesión de fisioterapia - Fortalecimiento muscular',
      doctor: 'Dr. Jiménez Torres',
      status: 'En curso',
    ),
    MedicalRecord(
      id: 6,
      date: '10/10/2024',
      type: 'Urgencia',
      description: 'Dolor agudo cervical - Contractura muscular',
      doctor: 'Dra. Sánchez Pérez',
      status: 'Completado',
    ),
    MedicalRecord(
      id: 7,
      date: '08/10/2024',
      type: 'Revisión',
      description: 'Evaluación de progreso en tratamiento',
      doctor: 'Dr. García Martínez',
      status: 'Pendiente',
    ),
    MedicalRecord(
      id: 8,
      date: '05/10/2024',
      type: 'Seguimiento',
      description: 'Terapia manual para fascitis plantar',
      doctor: 'Dra. López Fernández',
      status: 'En curso',
    ),
  ];

  /// Obtiene las historias clínicas filtradas por paciente.
  ///
  /// En una aplicación real, esto consultaría la base de datos
  /// usando el ID del paciente como filtro.
  static List<MedicalRecord> getMedicalRecordsForPatient(int patientId) {
    // Por simplicidad, devolvemos todas las historias de ejemplo
    // En una app real, esto se filtraría por patientId
    return sampleMedicalRecords;
  }
}
