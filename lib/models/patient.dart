class Patient {
  final int id;
  final String name;
  final String lastVisit;

  const Patient({
    required this.id,
    required this.name,
    required this.lastVisit,
  });

  // Método para obtener las iniciales del nombre
  String get initials {
    final names = name.split(' ');
    if (names.isEmpty) return '';
    
    final firstInitial = names[0].isNotEmpty ? names[0][0] : '';
    final secondInitial = names.length > 1 && names[1].isNotEmpty ? names[1][0] : '';
    
    return (firstInitial + secondInitial).toUpperCase();
  }
}
