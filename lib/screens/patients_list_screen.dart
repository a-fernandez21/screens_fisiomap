import 'package:flutter/material.dart';

class PatientsListScreen extends StatelessWidget {
  const PatientsListScreen({super.key});

  // Lista de ejemplo de pacientes (más adelante esto vendría de una base de datos)
  final List<Patient> patients = const [
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
      appBar: AppBar(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Encabezado con información de la clínica
            Container(
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
                  Icon(
                    Icons.local_hospital,
                    color: Colors.white,
                    size: 40,
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Clínica FisioMap',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Gestión de Pacientes',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Título de la lista
            Text(
              'Lista de Pacientes',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal[800],
              ),
            ),
            const SizedBox(height: 16),
            
            // Lista de pacientes
            Expanded(
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
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addNewPatient(context),
        backgroundColor: Colors.teal[600],
        foregroundColor: Colors.white,
        child: const Icon(Icons.person_add),
      ),
    );
  }

  void _onPatientTap(BuildContext context, Patient patient) {
    // Por ahora solo mostramos un mensaje, más adelante navegaremos a otra pantalla
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${patient.name}'),
        backgroundColor: Colors.teal[600],
      ),
    );
  }

  void _addNewPatient(BuildContext context) {
    // Por ahora solo mostramos un mensaje, más adelante abriremos un formulario
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de agregar paciente próximamente'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

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
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              // Avatar del paciente
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.teal[100],
                child: Text(
                  _getInitials(patient.name),
                  style: TextStyle(
                    color: Colors.teal[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Información del paciente
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      patient.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey[600],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Última visita: ${patient.lastVisit}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Icono de flecha
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    List<String> names = name.split(' ');
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