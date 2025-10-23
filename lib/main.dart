import 'package:flutter/material.dart';
import 'screens/patients_list_screen.dart';
import 'constants/app_constants.dart';
import 'constants/app_colors.dart';

/// Punto de entrada principal de la aplicación FisioMap.
///
/// Inicializa y ejecuta la aplicación Flutter.
void main() {
  runApp(const FisioMapApp());
}

/// Widget raíz de la aplicación FisioMap.
/// Configura el tema, el título y la pantalla inicial de la aplicación.
/// Utiliza Material Design 3 con una paleta de colores personalizada.
class FisioMapApp extends StatelessWidget {
  const FisioMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
        useMaterial3: true,
      ),
      home: const PatientsListScreen(),
    );
  }
}
