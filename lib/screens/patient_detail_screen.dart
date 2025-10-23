import 'package:flutter/material.dart';
import '../models/patient.dart';
import '../models/medical_record.dart';
import '../data/medical_records_data.dart';

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
      body: Column(
        children: [
          // Información del paciente en la parte superior (fija)
          Container(
            color: Colors.grey[50],
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: _PatientInfoContainer(patient: patient),
          ),
          // Lista scrolleable de historias clínicas
          Expanded(child: _MedicalHistorySectionWidget(patient: patient)),
        ],
      ),
      bottomNavigationBar: _BottomActionBar(patient: patient),
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

/// Contenedor colapsible que muestra la información del paciente.
class _PatientInfoContainer extends StatefulWidget {
  final Patient patient;

  const _PatientInfoContainer({required this.patient});

  @override
  State<_PatientInfoContainer> createState() => _PatientInfoContainerState();
}

class _PatientInfoContainerState extends State<_PatientInfoContainer>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _heightAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
          // Encabezado siempre visible con el nombre del paciente
          InkWell(
            onTap: _toggleExpanded,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Avatar del paciente
                  CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.teal[100],
                    child: Text(
                      widget.patient.initials,
                      style: TextStyle(
                        color: Colors.teal[800],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Nombre del paciente
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.patient.name,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal[800],
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Última visita: ${widget.patient.lastVisit}',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.grey[600],
                            height: 1.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Icono de expandir/colapsar
                  AnimatedRotation(
                    turns: _isExpanded ? 0.5 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.keyboard_arrow_down,
                      color: Colors.teal[600],
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Contenido expandible
          AnimatedBuilder(
            animation: _heightAnimation,
            builder: (context, child) {
              return SizeTransition(sizeFactor: _heightAnimation, child: child);
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(color: Colors.grey[300]),
                  const SizedBox(height: 12),
                  Text(
                    'Información Adicional',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal[700],
                    ),
                  ),
                  const SizedBox(height: 12),
                  _InfoRowWidget(
                    icon: Icons.phone,
                    label: 'Teléfono',
                    value: '+34 600 123 456',
                  ),
                  const SizedBox(height: 8),
                  _InfoRowWidget(
                    icon: Icons.email,
                    label: 'Email',
                    value:
                        '${widget.patient.name.toLowerCase().replaceAll(' ', '.')}@email.com',
                  ),
                  const SizedBox(height: 8),
                  _InfoRowWidget(
                    icon: Icons.cake,
                    label: 'Fecha de nacimiento',
                    value: '15/03/1985',
                  ),
                  const SizedBox(height: 8),
                  _InfoRowWidget(
                    icon: Icons.location_on,
                    label: 'Dirección',
                    value: 'Calle Example 123, Madrid',
                  ),
                ],
              ),
            ),
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
        Icon(icon, size: 16, color: Colors.teal[600]),
        const SizedBox(width: 10),
        Expanded(
          flex: 2,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
              height: 1.2,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
              height: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}

/// Widget que contiene la sección de historial médico del paciente.
class _MedicalHistorySectionWidget extends StatelessWidget {
  final Patient patient;

  const _MedicalHistorySectionWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    final medicalRecords = MedicalRecordsData.getMedicalRecordsForPatient(
      patient.id,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: _SectionTitleWidget(
            title: 'Historial Clínico',
            subtitle: '${medicalRecords.length} registros',
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: _MedicalRecordsListWidget(
            medicalRecords: medicalRecords,
            patient: patient,
          ),
        ),
      ],
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

/// Widget privado que renderiza la lista de historias clínicas.
class _MedicalRecordsListWidget extends StatelessWidget {
  final List<MedicalRecord> medicalRecords;
  final Patient patient;

  const _MedicalRecordsListWidget({
    required this.medicalRecords,
    required this.patient,
  });

  @override
  Widget build(BuildContext context) {
    if (medicalRecords.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services_outlined, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No hay historias clínicas registradas',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
    // Para Anamnesis, mostramos un layout más simple
    final isAnamnesis = record.type.toLowerCase() == 'anamnesis';
    
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
              if (!isAnamnesis) ...[
                const SizedBox(height: 12),
                _RecordDescriptionWidget(description: record.description),
              ],
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

/// Widget que implementa la barra inferior con botones de acción.
class _BottomActionBar extends StatelessWidget {
  final Patient patient;

  const _BottomActionBar({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Row(
          children: [
            Expanded(
              child: _BottomActionButton(
                icon: Icons.trending_up,
                text: 'Nuevo Seguimiento',
                color: Colors.green,
                onPressed: () => _onNewFollowUp(context),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _BottomActionButton(
                icon: Icons.assignment,
                text: 'Nueva Anamnesis',
                color: Colors.blue,
                onPressed: () => _onNewAnamnesis(context),
              ),
            ),
          ],
        ),
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

  void _onNewAnamnesis(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Nueva Anamnesis para ${patient.name}'),
        backgroundColor: Colors.blue[600],
      ),
    );
  }
}

/// Widget que representa un botón de la barra inferior.
class _BottomActionButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color color;
  final VoidCallback onPressed;

  const _BottomActionButton({
    required this.icon,
    required this.text,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
