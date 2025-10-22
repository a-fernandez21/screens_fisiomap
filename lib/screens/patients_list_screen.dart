import 'package:flutter/material.dart';

class PatientsListScreen extends StatelessWidget {
  const PatientsListScreen({super.key});

  // Lista de ejemplo de pacientes (más adelante esto vendría de una base de datos)
  static const List<Patient> _patients = [
    Patient(id: 1, name: 'Ana García López', lastVisit: '15/10/2024'),
    Patient(id: 2, name: 'Carlos Ruiz Martín', lastVisit: '18/10/2024'),
    Patient(id: 3, name: 'María José Fernández', lastVisit: '20/10/2024'),
    Patient(id: 4, name: 'José Antonio Díaz', lastVisit: '21/10/2024'),
    Patient(id: 5, name: 'Carmen Sánchez Pérez', lastVisit: '22/10/2024'),
    Patient(id: 6, name: 'Francisco Jiménez', lastVisit: '19/10/2024'),
    Patient(id: 7, name: 'Elena Moreno Castro', lastVisit: '17/10/2024'),
    Patient(id: 8, name: 'Miguel Ángel Torres', lastVisit: '16/10/2024'),
    Patient(id: 9, name: 'Pilar Romero Vega', lastVisit: '14/10/2024'),
    Patient(id: 10, name: 'Antonio López Ruiz', lastVisit: '13/10/2024'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: const _AppBarWidget(),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ClinicHeaderWidget(),
            SizedBox(height: 24),
            _SectionTitleWidget(title: 'Lista de Pacientes'),
            SizedBox(height: 16),
            _PatientsListWidget(patients: _patients),
          ],
        ),
      ),
      floatingActionButton: _AddPatientFAB(),
    );
  }
}

// Widget para el AppBar
class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'FisioMap - Pacientes',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.teal[700],
      elevation: 4,
      centerTitle: true,
    );
  }
}

// Widget para el encabezado de la clínica
class _ClinicHeaderWidget extends StatelessWidget {
  const _ClinicHeaderWidget();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[400]!, Colors.teal[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: const Column(
        children: [
          _ClinicIconWidget(),
          SizedBox(height: 8),
          _ClinicNameWidget(),
          _ClinicSubtitleWidget(),
        ],
      ),
    );
  }
}

// Widget para el ícono de la clínica
class _ClinicIconWidget extends StatelessWidget {
  const _ClinicIconWidget();

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.local_hospital,
      color: Colors.white,
      size: 40,
    );
  }
}

// Widget para el nombre de la clínica
class _ClinicNameWidget extends StatelessWidget {
  const _ClinicNameWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Clínica FisioMap',
      style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }
}

// Widget para el subtítulo de la clínica
class _ClinicSubtitleWidget extends StatelessWidget {
  const _ClinicSubtitleWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Gestión de Pacientes',
      style: TextStyle(
        fontSize: 16,
        color: Colors.white70,
      ),
    );
  }
}

// Widget para el título de sección
class _SectionTitleWidget extends StatelessWidget {
  final String title;

  const _SectionTitleWidget({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.teal[800],
      ),
    );
  }
}

// Widget para la lista de pacientes
class _PatientsListWidget extends StatelessWidget {
  final List<Patient> patients;

  const _PatientsListWidget({required this.patients});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: patients.length,
        itemBuilder: (context, index) {
          final patient = patients[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: PatientCard(
              patient: patient,
              onTap: () => _onPatientTap(context, patient),
            ),
          );
        },
      ),
    );
  }

  void _onPatientTap(BuildContext context, Patient patient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${patient.name}'),
        backgroundColor: Colors.teal[600],
      ),
    );
  }
}

// Widget para el botón flotante de agregar paciente
class _AddPatientFAB extends StatelessWidget {
  const _AddPatientFAB();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addNewPatient(context),
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      child: const Icon(Icons.person_add),
    );
  }

  void _addNewPatient(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de agregar paciente próximamente'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

// Widget para la tarjeta de paciente
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
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _PatientAvatarWidget(name: patient.name),
              const SizedBox(width: 16),
              _PatientInfoWidget(patient: patient),
              const _ArrowIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget para el avatar del paciente
class _PatientAvatarWidget extends StatelessWidget {
  final String name;

  const _PatientAvatarWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.teal[100],
      child: Text(
        _getInitials(name),
        style: TextStyle(
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final names = name.split(' ');
    String initials = '';
    
    if (names.isNotEmpty) {
      initials += names[0][0];
      if (names.length > 1) {
        initials += names[1][0];
      }
    }
    
    return initials.toUpperCase();
  }
}

// Widget para la información del paciente
class _PatientInfoWidget extends StatelessWidget {
  final Patient patient;

  const _PatientInfoWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PatientNameWidget(name: patient.name),
          const SizedBox(height: 4),
          _PatientLastVisitWidget(lastVisit: patient.lastVisit),
        ],
      ),
    );
  }
}

// Widget para el nombre del paciente
class _PatientNameWidget extends StatelessWidget {
  final String name;

  const _PatientNameWidget({required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    );
  }
}

// Widget para la última visita del paciente
class _PatientLastVisitWidget extends StatelessWidget {
  final String lastVisit;

  const _PatientLastVisitWidget({required this.lastVisit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          'Última visita: $lastVisit',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}

// Widget para el ícono de flecha
class _ArrowIconWidget extends StatelessWidget {
  const _ArrowIconWidget();

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_forward_ios,
      color: Colors.grey[400],
      size: 16,
    );
  }
}

// Modelo de datos para Patient
class Patient {
  final int id;
  final String name;
  final String lastVisit;

  const Patient({
    required this.id,
    required this.name,
    required this.lastVisit,
  });
}