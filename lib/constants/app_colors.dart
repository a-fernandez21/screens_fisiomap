import 'package:flutter/material.dart';

/// Clase que define la paleta de colores de la aplicación FisioMap.
///
/// Centraliza todos los colores utilizados en la aplicación para mantener
/// consistencia visual y facilitar cambios de tema. Todos los colores son
/// constantes estáticas para un acceso eficiente.
///
/// El constructor es privado para prevenir la instanciación de esta clase.
class AppColors {
  /// Constructor privado para prevenir instanciación.
  AppColors._();

  // Colores principales de la marca

  /// Color principal de la aplicación (teal).
  static const Color primary = Color(0xFF00BADB);

  /// Naranja
  static const Color orange = Color(0xFFF7BB43);

  /// Variante clara del color principal.
  static const Color primaryLight = Color(0xFF4DB6AC);

  // Colores de superficie y fondo

  /// Color de fondo de la aplicación.
  static final Color background = Colors.grey[50]!;

  /// Color de fondo de las tarjetas.
  static const Color cardBackground = Colors.white;

  // Colores de texto

  /// Color de texto principal (negro/gris oscuro).
  static const Color textPrimary = Color(0xFF212121);

  /// Color de texto secundario (gris medio).
  static const Color textSecondary = Color(0xFF757575);

  /// Color de texto claro (blanco).
  static const Color textLight = Colors.white;

  /// Color de texto claro secundario (teal claro).
  static const Color textLightSecondary = Color(0xFFB2DFDB);

  // Colores de elementos de UI

  /// Color de fondo para avatares.
  static final Color avatarBackground = Colors.teal[100]!;

  /// Color de texto para avatares.
  static final Color avatarText = const Color.fromARGB(255, 212, 184, 1)!;

  /// Color de íconos en gris claro.
  static final Color iconGrey = Colors.grey[400]!;

  /// Color de íconos en gris oscuro.
  static final Color iconDark = Colors.grey[600]!;
}
