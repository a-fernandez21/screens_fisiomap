import 'package:flutter/material.dart';

/// Dialog to select consultation type (phone, in-person, video call)
class ConsultationTypeDialog extends StatelessWidget {
  const ConsultationTypeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Tipo de consulta',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Phone consultation option
          _ConsultationTypeOption(
            icon: Icons.phone,
            label: 'Teléfono',
            color: Colors.blue,
            onTap: () => Navigator.of(context).pop('Teléfono'),
          ),
          const SizedBox(height: 12),
          // In-person consultation option
          _ConsultationTypeOption(
            icon: Icons.person,
            label: 'Presencial',
            color: Colors.green,
            onTap: () => Navigator.of(context).pop('Presencial'),
          ),
          const SizedBox(height: 12),
          // Video call consultation option
          _ConsultationTypeOption(
            icon: Icons.videocam,
            label: 'Videollamada',
            color: Colors.orange,
            onTap: () => Navigator.of(context).pop('Videollamada'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
      ],
    );
  }
}

/// Individual consultation type option button
class _ConsultationTypeOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ConsultationTypeOption({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: color.withOpacity(0.5)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(width: 16),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
