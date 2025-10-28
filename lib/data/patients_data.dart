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
    Patient(
      id: 1,
      name: 'Ana García López',
      lastVisit: '15/10/2024',
      address: 'Calle Mayor 123, Madrid',
      phone: '912 345 678',
      gender: 'Femenino',
      birthDate: '15/03/1985',
      age: 39,
      email: 'ana.garcia@email.com',
    ),
    Patient(
      id: 2,
      name: 'Carlos Ruiz Martín',
      lastVisit: '18/10/2024',
      address: 'Avenida de la Constitución 45, Madrid',
      phone: '913 456 789',
      gender: 'Masculino',
      birthDate: '22/07/1978',
      age: 46,
      email: 'carlos.ruiz@email.com',
    ),
    Patient(
      id: 3,
      name: 'María José Fernández',
      lastVisit: '20/10/2024',
      address: 'Plaza España 8, Madrid',
      phone: '914 567 890',
      gender: 'Femenino',
      birthDate: '10/11/1992',
      age: 31,
      email: 'mj.fernandez@email.com',
    ),
    Patient(
      id: 4,
      name: 'José Antonio Díaz',
      lastVisit: '21/10/2024',
      address: 'Calle Alcalá 67, Madrid',
      phone: '915 678 901',
      gender: 'Masculino',
      birthDate: '05/09/1965',
      age: 59,
      email: 'ja.diaz@email.com',
    ),
    Patient(
      id: 5,
      name: 'Carmen Sánchez Pérez',
      lastVisit: '22/10/2024',
      address: 'Gran Vía 34, Madrid',
      phone: '916 789 012',
      gender: 'Femenino',
      birthDate: '18/12/1988',
      age: 35,
      email: 'carmen.sanchez@email.com',
    ),
    Patient(
      id: 6,
      name: 'Francisco Jiménez',
      lastVisit: '19/10/2024',
      address: 'Paseo de la Castellana 90, Madrid',
      phone: '917 890 123',
      gender: 'Masculino',
      birthDate: '30/04/1972',
      age: 52,
      email: 'francisco.jimenez@email.com',
    ),
    Patient(
      id: 7,
      name: 'Elena Moreno Castro',
      lastVisit: '17/10/2024',
      address: 'Calle Serrano 56, Madrid',
      phone: '918 901 234',
      gender: 'Femenino',
      birthDate: '25/06/1995',
      age: 29,
      email: 'elena.moreno@email.com',
    ),
    Patient(
      id: 8,
      name: 'Miguel Ángel Torres',
      lastVisit: '16/10/2024',
      address: 'Calle Goya 78, Madrid',
      phone: '919 012 345',
      gender: 'Masculino',
      birthDate: '14/02/1980',
      age: 44,
      email: 'miguel.torres@email.com',
    ),
    Patient(
      id: 9,
      name: 'Pilar Romero Vega',
      lastVisit: '14/10/2024',
      address: 'Avenida América 12, Madrid',
      phone: '920 123 456',
      gender: 'Femenino',
      birthDate: '08/08/1990',
      age: 34,
      email: 'pilar.romero@email.com',
    ),
    Patient(
      id: 10,
      name: 'Antonio López Ruiz',
      lastVisit: '13/10/2024',
      address: 'Calle Bravo Murillo 89, Madrid',
      phone: '921 234 567',
      gender: 'Masculino',
      birthDate: '12/01/1968',
      age: 56,
      email: 'antonio.lopez@email.com',
    ),
  ];
}
