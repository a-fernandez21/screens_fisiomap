import 'package:flutter/material.dart';
import '../../../models/patient.dart';

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
class _PatientAvatarWidget extends StatelessWidget {
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

/// Widget privado que muestra el nombre del paciente.
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

/// Widget privado que muestra la fecha de última visita del paciente.
class _PatientLastVisitWidget extends StatelessWidget {
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
class _ArrowIconWidget extends StatelessWidget {
  const _ArrowIconWidget();

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16);
  }
}
