import '../models/patient.dart';

/// Clase que contiene datos de ejemplo para pacientes.
/// 
/// Esta es una clase utilitaria que proporciona una lista estática de pacientes
/// para propósitos de prueba y demostración. En una aplicación real, estos datos
/// provendrían de una base de datos o API.
/// 
/// El constructor es privado para prevenir la instanciación de esta clase,
/// ya que solo contiene miembros estáticos.
class PatientsData {
  /// Constructor privado para prevenir la instanciación.
  PatientsData._();

  /// Lista de pacientes de ejemplo con datos de prueba.
  /// 
  /// Contiene 10 pacientes ficticios con sus respectivos IDs, nombres y
  /// fechas de última visita.
  static const List<Patient> samplePatients = [
    Patient(id: 1, name: 'Ana García López', lastVisit: '15/10/2024'),
    Patient(id: 2, name: 'Carlos Ruiz Martín', lastVisit: '18/10/2024'),
    Patient(id: 3, name: 'María José Fernández', lastVisit: '20/10/2024'),
    Patient(id: 4, name: 'José Antonio Díaz', lastVisit: '21/10/2024'),
    Patient(id: 5, name: 'Carmen Sánchez Pérez', lastVisit: '22/10/2024'),
    Patient(id: 6, name: 'Francisco Jiménez', lastVisit: '19/10/2024'),
    Patient(id: 7, name: 'Elena Moreno Castro', lastVisit: '17/10/2024'),
    Patient(id: 8, name: 'Miguel Ángel Torres', lastVisit: '16/10/2024'),
    Patient(id: 9, name: 'Pilar Romero Vega', lastVisit: '14/10/2024'),
    Patient(id: 10, name: 'Antonio López Ruiz', lastVisit: '13/10/2024'),
  ];
}
