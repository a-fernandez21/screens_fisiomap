import 'package:flutter/material.dart';
import '../vm/patient_list_page_vm.dart';
import 'filter_option_checkbox.dart';

/// Filter side panel widget for patient list
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
  late Set<PatientFilterType> _tempFilters;

  @override
  void initState() {
    super.initState();
    // Initialize temp filters with current active filters
    _tempFilters = Set.from(widget.viewModel.activeFilters);
  }

  void _toggleTempFilter(PatientFilterType filterType) {
    setState(() {
      final Set<PatientFilterType> newFilters = Set.from(_tempFilters);
      
      // Handle mutually exclusive filters
      switch (filterType) {
        case PatientFilterType.alphabeticalAZ:
          newFilters.remove(PatientFilterType.alphabeticalZA);
          break;
        case PatientFilterType.alphabeticalZA:
          newFilters.remove(PatientFilterType.alphabeticalAZ);
          break;
        case PatientFilterType.lastVisitNewest:
          newFilters.remove(PatientFilterType.lastVisitOldest);
          break;
        case PatientFilterType.lastVisitOldest:
          newFilters.remove(PatientFilterType.lastVisitNewest);
          break;
        case PatientFilterType.genderMale:
          newFilters.remove(PatientFilterType.genderFemale);
          break;
        case PatientFilterType.genderFemale:
          newFilters.remove(PatientFilterType.genderMale);
          break;
      }
      
      // Toggle the selected filter
      if (newFilters.contains(filterType)) {
        newFilters.remove(filterType);
      } else {
        newFilters.add(filterType);
      }
      
      _tempFilters = newFilters;
    });
  }

  void _clearAllTempFilters() {
    setState(() {
      _tempFilters = {};
    });
  }

  void _applyFilters() {
    widget.viewModel.activeFilters = _tempFilters;
    widget.viewModel.applyFilters();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      color: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Filtrar pacientes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (_tempFilters.isNotEmpty)
                        TextButton(
                          onPressed: _clearAllTempFilters,
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                          ),
                          child: const Text(
                            'Limpiar',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.pop(context),
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Divider(),
              const SizedBox(height: 8),
              // Filter options
              Expanded(
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
                        isSelected: _tempFilters.contains(
                          PatientFilterType.alphabeticalAZ,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.alphabeticalAZ,
                        ),
                      ),
                      FilterOptionCheckbox(
                        icon: Icons.arrow_upward,
                        title: 'Z → A',
                        subtitle: 'Ordenar de Z a A',
                        isSelected: _tempFilters.contains(
                          PatientFilterType.alphabeticalZA,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.alphabeticalZA,
                        ),
                      ),
                  const SizedBox(height: 16),
                  // Last visit section
                  _buildSectionTitle('Fecha de visita'),
                  FilterOptionCheckbox(
                        icon: Icons.calendar_today,
                        title: 'Más reciente primero',
                        subtitle: 'Ordenar por fecha descendente',
                        isSelected: _tempFilters.contains(
                          PatientFilterType.lastVisitNewest,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.lastVisitNewest,
                        ),
                      ),
                      FilterOptionCheckbox(
                        icon: Icons.calendar_today_outlined,
                        title: 'Más antigua primero',
                        subtitle: 'Ordenar por fecha ascendente',
                        isSelected: _tempFilters.contains(
                          PatientFilterType.lastVisitOldest,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.lastVisitOldest,
                        ),
                      ),
                  const SizedBox(height: 16),
                  // Gender section
                  _buildSectionTitle('Sexo'),
                  FilterOptionCheckbox(
                        icon: Icons.male,
                        title: 'Masculino',
                        subtitle: 'Mostrar solo hombres',
                        isSelected: _tempFilters.contains(
                          PatientFilterType.genderMale,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.genderMale,
                        ),
                      ),
                      FilterOptionCheckbox(
                        icon: Icons.female,
                        title: 'Femenino',
                        subtitle: 'Mostrar solo mujeres',
                        isSelected: _tempFilters.contains(
                          PatientFilterType.genderFemale,
                        ),
                        onTap: () => _toggleTempFilter(
                          PatientFilterType.genderFemale,
                        ),
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
                  onPressed: _applyFilters,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 45, 183, 221),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    _tempFilters.isEmpty
                        ? 'Cerrar'
                        : 'Aplicar ${_tempFilters.length} filtro${_tempFilters.length > 1 ? 's' : ''}',
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
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6, top: 2),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Color.fromARGB(255, 0, 0, 0),
        ),
      ),
    );
  }
}
