import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyles {
  AppTextStyles._();

  // Estilos de encabezado
  static const TextStyle appBarTitle = TextStyle(
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
    fontSize: 20,
  );

  static const TextStyle clinicName = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textLight,
  );

  static const TextStyle clinicSubtitle = TextStyle(
    fontSize: 16,
    color: AppColors.textLightSecondary,
  );

  // Estilos de sección
  static TextStyle sectionTitle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: AppColors.avatarText,
  );

  // Estilos de tarjeta de paciente
  static const TextStyle patientName = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle patientInfo = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle avatarInitials = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
}
