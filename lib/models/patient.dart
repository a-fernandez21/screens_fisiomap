/// Modelo de datos que representa a un paciente de la clínica.
///
/// Contiene la información básica del paciente necesaria para
/// mostrarla en la interfaz de usuario.
class Patient {
  /// Identificador único del paciente.
  final int id;

  /// Nombre completo del paciente.
  final String name;

  /// Fecha de la última visita del paciente en formato String.
  final String lastVisit;

  /// Dirección del paciente.
  final String? address;

  /// Número de teléfono del paciente.
  final String? phone;

  /// Sexo del paciente (Masculino, Femenino, Otro).
  final String? gender;

  /// Fecha de nacimiento del paciente.
  final String? birthDate;

  /// Edad del paciente.
  final int? age;

  /// Correo electrónico del paciente.
  final String? email;

  /// Constructor para crear una instancia de [Patient].
  const Patient({
    required this.id,
    required this.name,
    required this.lastVisit,
    this.address,
    this.phone,
    this.gender,
    this.birthDate,
    this.age,
    this.email,
  });

  /// Obtiene las iniciales del nombre del paciente.
  ///
  /// Toma la primera letra del primer nombre y del segundo nombre (si existe)
  /// y las retorna en mayúsculas. Por ejemplo: "Ana García" → "AG"
  String get initials {
    final names = name.split(' ');
    if (names.isEmpty) return '';

    final firstInitial = names[0].isNotEmpty ? names[0][0] : '';
    final secondInitial =
        names.length > 1 && names[1].isNotEmpty ? names[1][0] : '';

    return (firstInitial + secondInitial).toUpperCase();
  }
}
