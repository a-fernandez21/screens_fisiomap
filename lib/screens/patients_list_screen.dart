import 'package:flutter/material.dart';

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

  /// Lista estática de pacientes de ejemplo.
  /// En una aplicación real, estos datos provendrían de una base de datos.
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

/// Widget privado que implementa el AppBar de la pantalla de pacientes.
/// 
/// Muestra el título "FisioMap - Pacientes" centrado con estilo personalizado.
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

/// Widget privado que muestra el encabezado visual de la clínica.
/// 
/// Incluye un contenedor con gradiente, ícono de hospital, nombre de la clínica
/// y subtítulo. Todos los elementos visuales están organizados verticalmente.
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

/// Widget privado que muestra el ícono de hospital en el encabezado.
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

/// Widget privado que muestra el nombre de la clínica en el encabezado.
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

/// Widget privado que muestra el subtítulo descriptivo de la clínica.
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

/// Widget privado que muestra un título de sección estilizado.
/// 
/// Se utiliza para mostrar títulos como "Lista de Pacientes" con el
/// estilo tipográfico apropiado.
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
  /// Muestra un SnackBar con el nombre del paciente seleccionado.
  /// En una implementación futura, esto navegaría a una pantalla de detalles.
  void _onPatientTap(BuildContext context, Patient patient) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Seleccionaste: ${patient.name}'),
        backgroundColor: Colors.teal[600],
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

/// Widget privado que muestra el avatar circular del paciente.
/// 
/// Genera y muestra las iniciales del nombre del paciente en un
/// [CircleAvatar] con colores personalizados.
class _PatientAvatarWidget extends StatelessWidget {
  /// Nombre del paciente del cual extraer las iniciales.
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

  /// Extrae las iniciales del nombre del paciente.
  /// 
  /// Toma la primera letra del primer nombre y la primera letra del segundo
  /// nombre (si existe) y las retorna en mayúsculas.
  /// 
  /// Ejemplo: "Ana García López" retorna "AG"
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

/// Widget privado que muestra el ícono de flecha indicador de acción.
/// 
/// Proporciona una pista visual de que el elemento es clickeable.
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

/// Modelo de datos que representa a un paciente de la clínica.
/// 
/// Contiene la información básica necesaria para mostrar un paciente
/// en la lista y en otras pantallas de la aplicación.
class Patient {
  /// Identificador único del paciente.
  final int id;
  
  /// Nombre completo del paciente.
  final String name;
  
  /// Fecha de la última visita del paciente en formato String.
  final String lastVisit;

  /// Constructor para crear una instancia de [Patient].
  const Patient({
    required this.id,
    required this.name,
    required this.lastVisit,
  });
}