import 'package:flutter/material.dart';
import '../../../models/patient.dart';
import 'patient_avatar.dart';
import 'patient_arrow.dart';
import 'patient_info.dart';

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
              PatientAvatarWidget(patient: patient),
              const SizedBox(width: 16),
              PatientInfoWidget(patient: patient),
              const ArrowIconWidget(),
            ],
          ),
        ),
      ),
    );
  }
}







