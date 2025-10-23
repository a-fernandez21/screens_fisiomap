import 'package:flutter/material.dart';
import '../models/patient.dart';

/// Pantalla de detalles del paciente seleccionado.
///
/// Muestra la información completa del paciente y proporciona acceso
/// a las funcionalidades principales como anamnesis, seguimiento e historial clínico.
class PatientDetailScreen extends StatelessWidget {
  /// Datos del paciente a mostrar.
  final Patient patient;

  const PatientDetailScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _PatientDetailAppBar(patientName: patient.name),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _PatientHeaderWidget(patient: patient),
            const SizedBox(height: 32),
            _PatientInfoContainer(patient: patient),
            const SizedBox(height: 32),
            _ActionButtonsWidget(patient: patient),
          ],
        ),
      ),
    );
  }
}

/// Widget privado que implementa el AppBar de la pantalla de detalles del paciente.
class _PatientDetailAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String patientName;

  const _PatientDetailAppBar({required this.patientName});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Detalles del Paciente',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 45, 183, 221),
      elevation: 4,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}

/// Widget que muestra el encabezado con el avatar y nombre del paciente.
class _PatientHeaderWidget extends StatelessWidget {
  final Patient patient;

  const _PatientHeaderWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LargePatientAvatar(name: patient.name),
        const SizedBox(width: 20),
        Expanded(
          child: Text(
            patient.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget que muestra un avatar circular grande del paciente.
class _LargePatientAvatar extends StatelessWidget {
  final String name;

  const _LargePatientAvatar({required this.name});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 40,
      backgroundColor: Colors.teal[100],
      child: Text(
        _getInitials(name),
        style: TextStyle(
          color: Colors.teal[800],
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
      ),
    );
  }

  /// Extrae las iniciales del nombre del paciente.
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

/// Contenedor que muestra toda la información del paciente.
class _PatientInfoContainer extends StatelessWidget {
  final Patient patient;

  const _PatientInfoContainer({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información del Paciente',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 20),
          _InfoRowWidget(
            icon: Icons.person,
            label: 'ID Paciente',
            value: '#${patient.id.toString().padLeft(3, '0')}',
          ),
          const SizedBox(height: 16),
          _InfoRowWidget(
            icon: Icons.badge,
            label: 'Nombre completo',
            value: patient.name,
          ),
          const SizedBox(height: 16),
          _InfoRowWidget(
            icon: Icons.calendar_today,
            label: 'Última visita',
            value: patient.lastVisit,
          ),
          const SizedBox(height: 16),
          _InfoRowWidget(
            icon: Icons.phone,
            label: 'Teléfono',
            value: '+34 600 123 456', // Datos de ejemplo
          ),
          const SizedBox(height: 16),
          _InfoRowWidget(
            icon: Icons.email,
            label: 'Email',
            value:
                '${patient.name.toLowerCase().replaceAll(' ', '.')}@email.com',
          ),
          const SizedBox(height: 16),
          _InfoRowWidget(
            icon: Icons.cake,
            label: 'Fecha de nacimiento',
            value: '15/03/1985', // Datos de ejemplo
          ),
        ],
      ),
    );
  }
}

/// Widget que representa una fila de información con icono, etiqueta y valor.
class _InfoRowWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRowWidget({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.teal[600]),
        const SizedBox(width: 12),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget que contiene los tres botones de acción principales.
class _ActionButtonsWidget extends StatelessWidget {
  final Patient patient;

  const _ActionButtonsWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _ActionButton(
          icon: Icons.assignment,
          text: 'Nueva Anamnesis',
          color: Colors.blue,
          onPressed: () => _onNewAnamnesis(context),
        ),
        const SizedBox(height: 16),
        _ActionButton(
          icon: Icons.trending_up,
          text: 'Nuevo Seguimiento',
          color: Colors.green,
          onPressed: () => _onNewFollowUp(context),
        ),
        const SizedBox(height: 16),
        _ActionButton(
          icon: Icons.history,
          text: 'Ver Historial Clínico',
          color: Colors.orange,
          onPressed: () => _onViewHistory(context),
        ),
      ],
    );
  }

  void _onNewAnamnesis(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nueva Anamnesis para ${patient.name}'),
        backgroundColor: Colors.blue[600],
      ),
    );
  }

  void _onNewFollowUp(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nuevo Seguimiento para ${patient.name}'),
        backgroundColor: Colors.green[600],
      ),
    );
  }

  void _onViewHistory(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Historial Clínico de ${patient.name}'),
        backgroundColor: Colors.orange[600],
      ),
    );
  }
}

/// Widget que representa un botón de acción con icono y texto.
class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(
              text,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
