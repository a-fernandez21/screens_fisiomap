import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/medical_record.dart';
import '../data/medical_records_data.dart';

/// Pantalla que muestra el historial clínico de un paciente.
///
/// Esta pantalla incluye:
/// - AppBar con el nombre del paciente
/// - Lista scrolleable de historias clínicas
/// - Cada historia clínica es clickeable y muestra información detallada
///
/// La estructura es similar a la lista de pacientes pero adaptada para historias clínicas.
class MedicalHistoryScreen extends StatelessWidget {
  /// Datos del paciente cuyo historial se va a mostrar.
  final Patient patient;

  const MedicalHistoryScreen({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    final medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(
      patient.id,
    );

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: _MedicalHistoryAppBar(patientName: patient.name),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            _PatientSummaryWidget(patient: patient),
            const SizedBox(height: 24),
            _SectionTitleWidget(
              title: 'Historial Clínico',
              subtitle: '${medicalRecords.length} registros',
            ),
            const SizedBox(height: 16),
            _MedicalRecordsListWidget(medicalRecords: medicalRecords),
          ],
        ),
      ),
      floatingActionButton: _AddRecordFAB(patient: patient),
    );
  }
}

/// Widget privado que implementa el AppBar de la pantalla de historial clínico.
class _MedicalHistoryAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String patientName;

  const _MedicalHistoryAppBar({required this.patientName});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'Historial Clínico',
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

/// Widget que muestra un resumen del paciente en la parte superior.
class _PatientSummaryWidget extends StatelessWidget {
  final Patient patient;

  const _PatientSummaryWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.teal[100],
            child: Text(
              patient.initials,
              style: TextStyle(
                color: Colors.teal[800],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.name,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Última visita: ${patient.lastVisit}',
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget que muestra el título de la sección con un subtítulo opcional.
class _SectionTitleWidget extends StatelessWidget {
  final String title;
  final String? subtitle;

  const _SectionTitleWidget({required this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 4),
          Text(
            subtitle!,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}

/// Widget privado que renderiza la lista completa de historias clínicas.
class _MedicalRecordsListWidget extends StatelessWidget {
  final List<MedicalRecord> medicalRecords;

  const _MedicalRecordsListWidget({required this.medicalRecords});

  @override
  Widget build(BuildContext context) {
    if (medicalRecords.isEmpty) {
      return const Expanded(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.medical_services_outlined,
                size: 64,
                color: Colors.grey,
              ),
              SizedBox(height: 16),
              Text(
                'No hay historias clínicas registradas',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.builder(
        itemCount: medicalRecords.length,
        itemBuilder: (context, index) {
          final record = medicalRecords[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: MedicalRecordCard(
              record: record,
              onTap: () => _onRecordTap(context, record),
            ),
          );
        },
      ),
    );
  }

  /// Maneja el evento de tocar una tarjeta de historia clínica.
  void _onRecordTap(BuildContext context, MedicalRecord record) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Registro ${record.type} - ${record.date}'),
        backgroundColor: record.typeColor,
      ),
    );
  }
}

/// Widget público que representa una tarjeta de historia clínica individual.
class MedicalRecordCard extends StatelessWidget {
  final MedicalRecord record;
  final VoidCallback onTap;

  const MedicalRecordCard({
    super.key,
    required this.record,
    required this.onTap,
  });

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _RecordHeaderWidget(record: record),
              const SizedBox(height: 12),
              _RecordDescriptionWidget(description: record.description),
              const SizedBox(height: 12),
              _RecordFooterWidget(record: record),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget que muestra la cabecera de la historia clínica con tipo y fecha.
class _RecordHeaderWidget extends StatelessWidget {
  final MedicalRecord record;

  const _RecordHeaderWidget({required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: record.typeColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: record.typeColor.withOpacity(0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(record.typeIcon, size: 16, color: record.typeColor),
              const SizedBox(width: 6),
              Text(
                record.type,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: record.typeColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Row(
          children: [
            Icon(Icons.calendar_today, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 4),
            Text(
              record.date,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Widget que muestra la descripción de la historia clínica.
class _RecordDescriptionWidget extends StatelessWidget {
  final String description;

  const _RecordDescriptionWidget({required this.description});

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black87,
        height: 1.3,
      ),
    );
  }
}

/// Widget que muestra el pie de la historia clínica con doctor y estado.
class _RecordFooterWidget extends StatelessWidget {
  final MedicalRecord record;

  const _RecordFooterWidget({required this.record});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.person, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            record.doctor,
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: record.statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: record.statusColor.withOpacity(0.3)),
          ),
          child: Text(
            record.status,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: record.statusColor,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget privado que implementa el botón flotante de acción (FAB).
class _AddRecordFAB extends StatelessWidget {
  final Patient patient;

  const _AddRecordFAB({required this.patient});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _addNewRecord(context),
      backgroundColor: Colors.teal[600],
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }

  void _addNewRecord(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Agregar nueva historia clínica para ${patient.name}'),
        backgroundColor: Colors.teal[600],
      ),
    );
  }
}
