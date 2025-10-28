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
        appBar: const PatientListAppBar(),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 24),
              const SectionTitleWidget(title: 'Lista de Pacientes'),
              const SizedBox(height: 16),
              // Display loading, empty state, or patient list
              if (model.busy)
                const Expanded(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (model.isEmpty)
                const Expanded(
                  child: EmptyStateWidget(),
                )
              else
                PatientsListWidget(
                  patients: model.patients,
                  onPatientTap: (patient) =>
                      model.navigateToPatientDetail(context, patient),
                ),
            ],
          ),
        ),
        floatingActionButton: AddPatientFAB(
          onPressed: () => model.addNewPatient(context),
        ),
      ),
    );
  }
}
