import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Clase que define los estilos de texto de la aplicación FisioMap.
/// 
/// Centraliza todos los estilos de texto utilizados en la aplicación para
/// mantener consistencia tipográfica y facilitar cambios de diseño.
/// Todos los estilos son constantes estáticas para un acceso eficiente.
/// 
/// El constructor es privado para prevenir la instanciación de esta clase.
class AppTextStyles {
  /// Constructor privado para prevenir instanciación.
  AppTextStyles._();

  // Estilos para encabezados y títulos
  
  /// Estilo para el título del AppBar.
  static const TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    fontSize: 20,
  );

  /// Estilo para el nombre de la clínica en el encabezado.
  static const TextStyle clinicName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  /// Estilo para el subtítulo de la clínica en el encabezado.
  static const TextStyle clinicSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textLightSecondary,
  );

  // Estilos para títulos de sección
  
  /// Estilo para los títulos de sección (ej: "Lista de Pacientes").
  static TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.avatarText,
  );

  // Estilos para elementos de tarjeta de paciente
  
  /// Estilo para el nombre del paciente en la tarjeta.
  static const TextStyle patientName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  /// Estilo para información secundaria del paciente (ej: fecha de visita).
  static const TextStyle patientInfo = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  /// Estilo para las iniciales en el avatar del paciente.
  static const TextStyle avatarInitials = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}
