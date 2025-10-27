import 'package:flutter/material.dart';

/// Editable text container for session notes.
///
/// Features:
/// - White rounded container with shadow
/// - Border changes color when editing (teal)
/// - Header with edit icon and title
/// - Expandable TextField filling available space
class EditableTextContainer extends StatelessWidget {
  final TextEditingController controller;
  final bool isEditing;
  final VoidCallback onTap;

  const EditableTextContainer({
    super.key,
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
          // Header with icon and title
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
          // Expandable text field
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
