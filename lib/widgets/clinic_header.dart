import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

class ClinicHeader extends StatelessWidget {
  const ClinicHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primaryLight, AppColors.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(AppConstants.shadowOpacity),
            spreadRadius: AppConstants.shadowSpreadRadius,
            blurRadius: AppConstants.shadowBlurRadius,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        children: [
          Icon(
            Icons.local_hospital,
            color: AppColors.textLight,
            size: AppConstants.iconSize,
          ),
          SizedBox(height: AppConstants.smallSpacing),
          Text(
            AppConstants.clinicName,
            style: AppTextStyles.clinicName,
          ),
          Text(
            AppConstants.clinicSubtitle,
            style: AppTextStyles.clinicSubtitle,
          ),
        ],
      ),
    );
  }
}
