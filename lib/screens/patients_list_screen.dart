import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../data/patients_data.dart';
import 'patient_detail_screen.dart';

/// Pantalla principal que muestra la lista de pacientes de la clínica FisioMap.
///
/// Esta pantalla incluye:
/// - AppBar con el título de la aplicación
/// - Encabezado visual de la clínica
/// - Lista scrolleable de pacientes
/// - Botón flotante para agregar nuevos pacientes
///
/// Cada paciente en la lista es clickeable y muestra información básica.
class PatientsListScreen extends StatelessWidget {
  const PatientsListScreen({super.key});

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
            SizedBox(height: 24),
            _SectionTitleWidget(title: 'Lista de Pacientes'),
            SizedBox(height: 16),
            _PatientsListWidget(patients: PatientsData.samplePatients),
          ],
        ),
      ),
      floatingActionButton: _AddPatientFAB(),
    );
  }
}

/// Widget privado que implementa el AppBar de la pantalla de pacientes.
///
/// Muestra el título "Pacientes" centrado con estilo personalizado.
class _AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const _AppBarWidget();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Pacientes',
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 45, 183, 221),
      elevation: 4,
      centerTitle: true,
    );
  }
}

class _SectionTitleWidget extends StatelessWidget {
  /// Texto del título a mostrar.
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

/// Widget privado que renderiza la lista completa de pacientes.
///
/// Utiliza un [ListView.builder] para renderizar eficientemente la lista
/// de pacientes. Cada elemento es una [PatientCard] clickeable que ejecuta
/// una acción al ser seleccionada.
class _PatientsListWidget extends StatelessWidget {
  /// Lista de pacientes a mostrar.
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

  /// Maneja el evento de tocar una tarjeta de paciente.
  ///
  /// Navega a la pantalla de detalles del paciente seleccionado.
  void _onPatientTap(BuildContext context, Patient patient) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PatientDetailScreen(patient: patient),
      ),
    );
  }
}

/// Widget privado que implementa el botón flotante de acción (FAB).
///
/// Permite iniciar el proceso de agregar un nuevo paciente a la lista.
/// Actualmente muestra un mensaje de funcionalidad pendiente.
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

  /// Maneja el evento de presionar el botón de agregar paciente.
  ///
  /// Actualmente muestra un SnackBar indicando que la funcionalidad está
  /// en desarrollo. En el futuro, abrirá un formulario o pantalla para
  /// agregar un nuevo paciente.
  void _addNewPatient(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad de agregar paciente próximamente'),
        backgroundColor: Colors.orange,
      ),
    );
  }
}

/// Widget público que representa una tarjeta de paciente individual.
///
/// Muestra información del paciente en un formato card con:
/// - Avatar circular con iniciales
/// - Nombre completo
/// - Fecha de última visita con ícono
/// - Indicador visual de interacción (flecha)
///
/// Es clickeable y ejecuta el callback [onTap] proporcionado.
class PatientCard extends StatelessWidget {
  /// Datos del paciente a mostrar.
  final Patient patient;

  /// Callback ejecutado al tocar la tarjeta.
  final VoidCallback onTap;

  const PatientCard({super.key, required this.patient, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _PatientAvatarWidget(patient: patient),
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

/// Widget privado que muestra el avatar circular del paciente.
///
/// Genera y muestra las iniciales del nombre del paciente en un
/// [CircleAvatar] con colores personalizados.
class _PatientAvatarWidget extends StatelessWidget {
  /// Paciente del cual extraer las iniciales.
  final Patient patient;

  const _PatientAvatarWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 25,
      backgroundColor: Colors.teal[100],
      child: Text(
        patient.initials,
        style: TextStyle(
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }
}

/// Widget privado que agrupa la información textual del paciente.
///
/// Contiene el nombre del paciente y la fecha de última visita organizados
/// verticalmente.
class _PatientInfoWidget extends StatelessWidget {
  /// Datos del paciente a mostrar.
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

/// Widget privado que muestra el nombre del paciente con estilo destacado.
class _PatientNameWidget extends StatelessWidget {
  /// Nombre completo del paciente.
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

/// Widget privado que muestra la fecha de última visita del paciente.
///
/// Incluye un ícono de calendario junto con el texto de la fecha.
class _PatientLastVisitWidget extends StatelessWidget {
  /// Fecha de la última visita en formato String.
  final String lastVisit;

  const _PatientLastVisitWidget({required this.lastVisit});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          'Última visita: $lastVisit',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ],
    );
  }
}

/// Widget privado que muestra el ícono de flecha indicador de acción.
///
/// Proporciona una pista visual de que el elemento es clickeable.
class _ArrowIconWidget extends StatelessWidget {
  const _ArrowIconWidget();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16);
  }
}
