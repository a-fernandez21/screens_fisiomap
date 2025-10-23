import 'package:flutter/material.dart';
import '../models/patient.dart';

/// Pantalla para grabar/reproducir audio y editar texto de sesiones.
///
/// Esta pantalla se usa tanto para nuevas anamnesis como para nuevos seguimientos.
/// Incluye:
/// - Controles de audio (grabadora que solo reproduce)
/// - Contenedor de texto editable
/// - Botones de acción (Guardar Cambios / Confirmar Revisión)
class RecordSessionScreen extends StatefulWidget {
  /// Datos del paciente.
  final Patient patient;

  /// Tipo de sesión (Anamnesis o Seguimiento).
  final String sessionType;

  /// ID del registro médico (opcional, para sesiones existentes).
  final int? recordId;

  const RecordSessionScreen({
    super.key,
    required this.patient,
    required this.sessionType,
    this.recordId,
  });

  @override
  State<RecordSessionScreen> createState() => _RecordSessionScreenState();
}

class _RecordSessionScreenState extends State<RecordSessionScreen> {
  final TextEditingController _textController = TextEditingController();
  bool _isPlaying = false;
  bool _isEditing = false;
  String _audioStatus = 'Sin audio';

  @override
  void initState() {
    super.initState();
    _textController.text =
        'Haz clic aquí para empezar a escribir las notas de la sesión...';
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      _isPlaying = !_isPlaying;
      _audioStatus = _isPlaying ? 'Reproduciendo...' : 'Pausado';
    });

    // Aquí iría la lógica real de reproducción de audio
    if (_isPlaying) {
      // Simular que termina después de un tiempo
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && _isPlaying) {
          setState(() {
            _isPlaying = false;
            _audioStatus = 'Reproducción finalizada';
          });
        }
      });
    }
  }

  void _saveChanges() {
    print('💾 Botón Guardar Cambios presionado');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cambios guardados para ${widget.patient.name}'),
        backgroundColor: Colors.green[600],
      ),
    );
    print('🚪 Cerrando pantalla con estado: Pendiente');
    Navigator.of(context).pop('Pendiente');
  }

  void _confirmReview() {
    print('✅ Botón Confirmar Revisión presionado');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Revisión confirmada para ${widget.patient.name}'),
        backgroundColor: Colors.blue[600],
      ),
    );
    print('🚪 Cerrando pantalla con estado: Completado');
    Navigator.of(context).pop('Completado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: _RecordSessionAppBar(
        sessionType: widget.sessionType,
        patientName: widget.patient.name,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AudioRecorderWidget(
              isPlaying: _isPlaying,
              audioStatus: _audioStatus,
              onPlayPause: _togglePlayPause,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _EditableTextContainer(
                controller: _textController,
                isEditing: _isEditing,
                onTap: () {
                  setState(() {
                    _isEditing = true;
                    if (_textController.text ==
                        'Haz clic aquí para empezar a escribir las notas de la sesión...') {
                      _textController.clear();
                    }
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            _ActionButtonsWidget(
              onSaveChanges: _saveChanges,
              onConfirmReview: _confirmReview,
            ),
          ],
        ),
      ),
    );
  }
}

/// AppBar de la pantalla de grabación.
class _RecordSessionAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final String sessionType;
  final String patientName;

  const _RecordSessionAppBar({
    required this.sessionType,
    required this.patientName,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        sessionType,
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

/// Widget que muestra información básica del paciente.
class _PatientInfoWidget extends StatelessWidget {
  final Patient patient;

  const _PatientInfoWidget({required this.patient});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

/// Widget que simula un reproductor de audio estilo iPhone.
class _AudioRecorderWidget extends StatelessWidget {
  final bool isPlaying;
  final String audioStatus;
  final VoidCallback onPlayPause;

  const _AudioRecorderWidget({
    required this.isPlaying,
    required this.audioStatus,
    required this.onPlayPause,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color.fromARGB(255, 122, 239, 255),
            const Color.fromARGB(255, 255, 184, 85),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Línea de tiempo
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '0:00',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '3:45',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[400],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Barra de progreso
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: isPlaying ? 0.3 : 0.0,
              minHeight: 4,
              backgroundColor: Colors.grey[700],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ),
          const SizedBox(height: 20),
          // Controles de reproducción estilo iPhone
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Botón retroceder 15 segundos
              _PlayerButton(icon: Icons.replay_10, size: 28, onPressed: () {}),
              // Botón retroceder
              _PlayerButton(
                icon: Icons.skip_previous,
                size: 32,
                onPressed: () {},
              ),
              // Botón play/pause (más grande)
              GestureDetector(
                onTap: onPlayPause,
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Icon(
                    isPlaying ? Icons.pause : Icons.play_arrow,
                    size: 32,
                    color: Colors.grey[900],
                  ),
                ),
              ),
              // Botón adelantar
              _PlayerButton(icon: Icons.skip_next, size: 32, onPressed: () {}),
              // Botón adelantar 15 segundos
              _PlayerButton(icon: Icons.forward_10, size: 28, onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

/// Botón personalizado para el reproductor.
class _PlayerButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onPressed;

  const _PlayerButton({
    required this.icon,
    required this.size,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, size: size, color: Colors.white),
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(),
    );
  }
}

/// Contenedor de texto editable.
class _EditableTextContainer extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onTap;

  const _EditableTextContainer({
    required this.controller,
    required this.isEditing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isEditing ? Colors.teal : Colors.grey.shade300,
          width: isEditing ? 2 : 1,
        ),
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
          Row(
            children: [
              Icon(Icons.edit_note, color: Colors.teal[600], size: 24),
              const SizedBox(width: 12),
              Text(
                'Notas de la Sesión',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal[800],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GestureDetector(
              onTap: onTap,
              child: TextField(
                controller: controller,
                maxLines: null,
                expands: true,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: Colors.black87,
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Haz clic para editar...',
                  hintStyle: TextStyle(
                    color: Colors.grey[400],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget con los botones de acción.
class _ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onSaveChanges;
  final VoidCallback onConfirmReview;

  const _ActionButtonsWidget({
    required this.onSaveChanges,
    required this.onConfirmReview,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: onSaveChanges,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Guardar Cambios',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ElevatedButton(
            onPressed: onConfirmReview,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Confirmar Revisión',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
}
