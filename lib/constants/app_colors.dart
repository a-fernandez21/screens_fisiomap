import 'package:flutter/material.dart';

class AppColors {
  AppColors._(); // Constructor privado para prevenir instanciación

  // Colores principales
  static const Color primary = Color(0xFF00897B);
  static const Color primaryDark = Color(0xFF00695C);
  static const Color primaryLight = Color(0xFF4DB6AC);
  
  // Colores de superficie
  static final Color background = Colors.grey[50]!;
  static const Color cardBackground = Colors.white;
  
  // Colores de texto
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Colors.white;
  static const Color textLightSecondary = Color(0xFFB2DFDB);
  
  // Colores de acento
  static final Color avatarBackground = Colors.teal[100]!;
  static final Color avatarText = Colors.teal[800]!;
  static final Color iconGrey = Colors.grey[400]!;
  static final Color iconDark = Colors.grey[600]!;
}
