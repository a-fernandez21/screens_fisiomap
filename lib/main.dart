import 'package:flutter/material.dart';
import 'screens/patients_list_screen.dart';
import 'constants/app_constants.dart';
import 'constants/app_colors.dart';

void main() {
  runApp(const FisioMapApp());
}

class FisioMapApp extends StatelessWidget {
  const FisioMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      home: const PatientsListScreen(),
    );
  }
}


