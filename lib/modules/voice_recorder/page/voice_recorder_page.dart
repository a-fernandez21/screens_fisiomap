import 'package:flutter/material.dart';
import 'package:pumpun_core/view/base_widget.dart';
import 'package:screens_fisiomap/modules/voice_recorder/vm/voice_recorder_page_vm.dart';
import 'package:permission_handler/permission_handler.dart';

/// Voice Recorder Page - Record audio for anamnesis
class VoiceRecorderPage extends StatelessWidget {
  const VoiceRecorderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<VoiceRecorderPageViewModel>(
      model: VoiceRecorderPageViewModel(),
      onModelReady: (model) => model.onInit(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: AppBar(
          title: const Text('Grabar Audio'),
          backgroundColor: Colors.white,
          elevation: 1,
        ),
    body: model.busy
            ? const Center(child: CircularProgressIndicator())
            : _buildRecorderContent(context, model),
      ),
    );
  }



  // Build recorder content
  Widget _buildRecorderContent(
    BuildContext context,
    VoiceRecorderPageViewModel model,
  ) {
    return Column(
      children: [
        // Visual indicator
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated microphone icon
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: model.isRecording && !model.isPaused
                        ? const Color(0xFFFF5252).withOpacity(0.1)
                        : Colors.grey[200],
                  ),
                  child: Icon(
                    model.isRecording && !model.isPaused
                        ? Icons.mic
                        : Icons.mic_none,
                    size: 64,
                    color: model.isRecording && !model.isPaused
                        ? const Color(0xFFFF5252)
                        : Colors.grey[600],
                  ),
                ),
                const SizedBox(height: 32),
                
                // Duration display
                Text(
                  model.formattedDuration,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.w300,
                    color: Color(0xFF2D3142),
                  ),
                ),
                const SizedBox(height: 8),
                
                // Status text
                Text(
                  model.isRecording
                      ? (model.isPaused ? 'Pausado' : 'Grabando...')
                      : model.hasPermission
                          ? 'Listo para grabar'
                          : 'Toca el botón para solicitar permiso',
                  style: TextStyle(
                    fontSize: 16,
                    color: model.hasPermission ? Colors.grey[600] : Colors.orange[700],
                  ),
                ),
              ],
            ),
          ),
        ),
        
        // Control buttons
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: SafeArea(
            child: model.isRecording
                ? _buildRecordingControls(context, model)
                : _buildStartButton(context, model),
          ),
        ),
      ],
    );
  }

  // Build start recording button
  Widget _buildStartButton(
    BuildContext context,
    VoiceRecorderPageViewModel model,
  ) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton.icon(
        onPressed: () async {
          final permissionStatus = await model.startRecording();
          
          // If permission was denied, show dialog
          if (permissionStatus != null && !permissionStatus.isGranted) {
            if (!context.mounted) return;
            
            showDialog<void>(
              context: context,
              builder: (ctx) => AlertDialog(
                title: const Text('Permiso de micrófono requerido'),
                content: Text(
                  permissionStatus.isPermanentlyDenied
                      ? 'El permiso de micrófono está denegado permanentemente. '
                        'Debes activarlo manualmente en los Ajustes del iPhone.\n\n'
                        'Ve a: Ajustes → Screens Fisiomap → Micrófono → Activar'
                      : 'Esta app necesita acceso al micrófono para grabar audio de las sesiones clínicas.',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    child: const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      openAppSettings();
                      Navigator.of(ctx).pop();
                    },
                    child: const Text('Abrir Ajustes'),
                  ),
                ],
              ),
            );
          }
        },
        icon: Icon(
          model.hasPermission ? Icons.fiber_manual_record : Icons.mic,
          size: 24,
        ),
        label: Text(
          model.hasPermission ? 'Iniciar Grabación' : 'Solicitar Permiso y Grabar',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFFF5252),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  // Build recording controls (pause/resume, stop, cancel)
  Widget _buildRecordingControls(
    BuildContext context,
    VoiceRecorderPageViewModel model,
  ) {
    return Row(
      children: [
        // Cancel button
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () async {
              await model.cancelRecording();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
            icon: const Icon(Icons.close, size: 20),
            label: const Text('Cancelar'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.grey[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        
        // Pause/Resume button
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.grey[200],
          ),
          child: IconButton(
            onPressed: model.isPaused
                ? model.resumeRecording
                : model.pauseRecording,
            icon: Icon(
              model.isPaused ? Icons.play_arrow : Icons.pause,
              size: 28,
            ),
            color: const Color(0xFF2D3142),
            padding: const EdgeInsets.all(16),
          ),
        ),
        const SizedBox(width: 12),
        
        // Stop button
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              final path = await model.stopRecording();
              if (context.mounted) {
                Navigator.of(context).pop(path);
              }
            },
            icon: const Icon(Icons.stop, size: 20),
            label: const Text('Guardar'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
