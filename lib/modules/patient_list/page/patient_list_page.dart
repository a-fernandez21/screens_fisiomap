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
          filterButton: PopupMenuButton<PatientFilterType>(
            icon: Icon(
              model.currentFilter != PatientFilterType.none
                  ? Icons.filter_alt
                  : Icons.filter_alt_outlined,
              color: Colors.white,
            ),
            tooltip: 'Filtrar',
            onSelected: (filterType) =>
                model.onFilterSelected(filterType, context),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: PatientFilterType.none,
                child: Row(
                  children: [
                    Icon(Icons.clear),
                    SizedBox(width: 12),
                    Text('Sin filtro'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: PatientFilterType.alphabetical,
                child: Row(
                  children: [
                    Icon(Icons.sort_by_alpha),
                    SizedBox(width: 12),
                    Text('Orden alfabético'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: PatientFilterType.lastVisit,
                child: Row(
                  children: [
                    Icon(Icons.calendar_today),
                    SizedBox(width: 12),
                    Text('Última visita'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: PatientFilterType.gender,
                child: Row(
                  children: [
                    Icon(Icons.people),
                    SizedBox(width: 12),
                    Text('Por sexo'),
                  ],
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display active filter indicator
              if (model.currentFilter != PatientFilterType.none)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: _FilterChip(
                    label: _getFilterLabel(model),
                    onClear: () => model.applyFilter(PatientFilterType.none),
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

  String _getFilterLabel(PatientListPageViewModel model) {
    switch (model.currentFilter) {
      case PatientFilterType.alphabetical:
        return 'Filtro: Alfabético';
      case PatientFilterType.lastVisit:
        return 'Filtro: Última visita';
      case PatientFilterType.gender:
        return 'Filtro: ${model.selectedGender}';
      case PatientFilterType.none:
        return '';
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
