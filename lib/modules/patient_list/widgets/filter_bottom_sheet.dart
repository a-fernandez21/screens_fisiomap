import 'package:flutter/material.dart';
import '../vm/patient_list_page_vm.dart';
import 'filter_option_checkbox.dart';

/// Filter BottomSheet widget for patient list
class FilterBottomSheet extends StatefulWidget {
  final PatientListPageViewModel viewModel;

  const FilterBottomSheet({
    super.key,
    required this.viewModel,
  });

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Filtrar pacientes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  if (widget.viewModel.hasActiveFilters)
                    TextButton(
                      onPressed: () {
                        setState(() {
                          widget.viewModel.clearAllFilters();
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Limpiar todo'),
                    ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          // Filter options
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Alphabetical section
                  _buildSectionTitle('Orden alfabético'),
                  FilterOptionCheckbox(
                    icon: Icons.arrow_downward,
                    title: 'A → Z',
                    subtitle: 'Ordenar de A a Z',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.alphabeticalAZ,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.alphabeticalAZ,
                        );
                      });
                    },
                  ),
                  FilterOptionCheckbox(
                    icon: Icons.arrow_upward,
                    title: 'Z → A',
                    subtitle: 'Ordenar de Z a A',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.alphabeticalZA,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.alphabeticalZA,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Last visit section
                  _buildSectionTitle('Fecha de visita'),
                  FilterOptionCheckbox(
                    icon: Icons.calendar_today,
                    title: 'Más reciente primero',
                    subtitle: 'Ordenar por fecha descendente',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.lastVisitNewest,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.lastVisitNewest,
                        );
                      });
                    },
                  ),
                  FilterOptionCheckbox(
                    icon: Icons.calendar_today_outlined,
                    title: 'Más antigua primero',
                    subtitle: 'Ordenar por fecha ascendente',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.lastVisitOldest,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.lastVisitOldest,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                  // Gender section
                  _buildSectionTitle('Sexo'),
                  FilterOptionCheckbox(
                    icon: Icons.male,
                    title: 'Masculino',
                    subtitle: 'Mostrar solo hombres',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.genderMale,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.genderMale,
                        );
                      });
                    },
                  ),
                  FilterOptionCheckbox(
                    icon: Icons.female,
                    title: 'Femenino',
                    subtitle: 'Mostrar solo mujeres',
                    isSelected: widget.viewModel.activeFilters.contains(
                      PatientFilterType.genderFemale,
                    ),
                    onTap: () {
                      setState(() {
                        widget.viewModel.toggleFilter(
                          PatientFilterType.genderFemale,
                        );
                      });
                    },
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
          // Apply button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                widget.viewModel.applyFilters();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 45, 183, 221),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                widget.viewModel.activeFilters.isEmpty
                    ? 'Cerrar'
                    : 'Aplicar ${widget.viewModel.activeFilters.length} filtro${widget.viewModel.activeFilters.length > 1 ? 's' : ''}',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8, top: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.grey,
        ),
      ),
    );
  }
}
