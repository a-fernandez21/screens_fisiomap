import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import '../vm/patient_list_page_vm.dart';
import '../widgets/patient_list_widgets.dart';

/// Patient List Page - Main screen displaying clinic patient list
class PatientListPage extends StatelessWidget {
  const PatientListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<PatientListPageViewModel>(
      model: PatientListPageViewModel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: PatientListAppBar(
          filterButton: IconButton(
            icon: Icon(
              model.hasActiveFilters
                  ? Icons.filter_alt
                  : Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            tooltip: 'Filtrar',
            onPressed: () => _showFilterBottomSheet(context, model),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display active filter chips
              if (model.hasActiveFilters)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Wrap(
                    spacing: 8.0,
                    runSpacing: 4.0,
                    children: model.activeFilters.map((filter) {
                      return _FilterChip(
                        label: _getFilterLabel(filter),
                        onClear: () {
                          model.toggleFilter(filter);
                          model.applyFilters();
                        },
                      );
                    }).toList(),
                  ),
                ),
              // Display loading, empty state, or patient list
              if (model.busy)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (model.isEmpty)
                const Expanded(child: EmptyStateWidget())
              else
                PatientsListWidget(
                  patients: model.patients,
                  onPatientTap: (patient) =>
                      model.navigateToPatientDetail(context, patient),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Show filter bottom sheet
  void _showFilterBottomSheet(
    BuildContext context,
    PatientListPageViewModel model,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => FilterBottomSheet(viewModel: model),
    );
  }

  /// Get label text for filter chip
  String _getFilterLabel(PatientFilterType filter) {
    switch (filter) {
      case PatientFilterType.alphabeticalAZ:
        return 'A → Z';
      case PatientFilterType.alphabeticalZA:
        return 'Z → A';
      case PatientFilterType.lastVisitNewest:
        return 'Más reciente';
      case PatientFilterType.lastVisitOldest:
        return 'Más antigua';
      case PatientFilterType.genderMale:
        return 'Masculino';
      case PatientFilterType.genderFemale:
        return 'Femenino';
    }
  }
}

/// Widget to display active filter indicator
class _FilterChip extends StatelessWidget {
  final String label;
  final VoidCallback onClear;

  const _FilterChip({
    required this.label,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(label),
      deleteIcon: const Icon(Icons.close, size: 18),
      onDeleted: onClear,
      backgroundColor: const Color.fromARGB(255, 45, 183, 221).withOpacity(0.1),
      deleteIconColor: const Color.fromARGB(255, 45, 183, 221),
      labelStyle: const TextStyle(
        color: Color.fromARGB(255, 45, 183, 221),
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
