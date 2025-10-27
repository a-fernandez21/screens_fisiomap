import 'package:flutter/material.dart';

/// Bottom action buttons for session management.
///
/// Two buttons:
/// - Guardar Cambios (Green) - Save changes and return 'Pendiente'
/// - Confirmar Revisión (Blue) - Confirm review and return 'Completado'
class ActionButtonsWidget extends StatelessWidget {
  final VoidCallback onSaveChanges;
  final VoidCallback onConfirmReview;

  const ActionButtonsWidget({
    super.key,
    required this.onSaveChanges,
    required this.onConfirmReview,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Save changes button (green)
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
        // Confirm review button (blue)
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
