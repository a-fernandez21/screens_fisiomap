import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import '../constants/app_constants.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  final VoidCallback onTap;

  const PatientCard({
    super.key,
    required this.patient,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppConstants.cardElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.cardPadding),
          child: Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: AppConstants.itemSpacing),
              _buildPatientInfo(),
              _buildArrowIcon(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return CircleAvatar(
      radius: AppConstants.avatarRadius,
      backgroundColor: AppColors.avatarBackground,
      child: Text(
        patient.initials,
        style: AppTextStyles.avatarInitials.copyWith(
          color: AppColors.avatarText,
        ),
      ),
    );
  }

  Widget _buildPatientInfo() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            patient.name,
            style: AppTextStyles.patientName,
          ),
          const SizedBox(height: AppConstants.tinySpacing),
          Row(
            children: [
              Icon(
                Icons.calendar_today,
                size: AppConstants.smallIconSize,
                color: AppColors.iconDark,
              ),
              const SizedBox(width: AppConstants.tinySpacing),
              Text(
                '${AppConstants.lastVisitLabel}${patient.lastVisit}',
                style: AppTextStyles.patientInfo,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildArrowIcon() {
    return Icon(
      Icons.arrow_forward_ios,
      color: AppColors.iconGrey,
      size: AppConstants.smallIconSize,
    );
  }
}
