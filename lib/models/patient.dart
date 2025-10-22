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

  /// Constructor para crear una instancia de [Patient].
  const Patient({
    required this.id,
    required this.name,
    required this.lastVisit,
  });

  /// Obtiene las iniciales del nombre del paciente.
  /// 
  /// Toma la primera letra del primer nombre y del segundo nombre (si existe)
  /// y las retorna en mayúsculas. Por ejemplo: "Ana García" → "AG"
  String get initials {
    final names = name.split(' ');
    if (names.isEmpty) return '';
    
    final firstInitial = names[0].isNotEmpty ? names[0][0] : '';
    final secondInitial = names.length > 1 && names[1].isNotEmpty ? names[1][0] : '';
    
    return (firstInitial + secondInitial).toUpperCase();
  }
}
