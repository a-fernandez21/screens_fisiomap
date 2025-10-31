import 'package:flutter/material.dart';
import 'package:screens_fisiomap/models/patient.dart';

/// Collapsible patient information card with animated expansion
class PatientInfoContainer extends StatefulWidget {
  final Patient patient;
  final VoidCallback? onEditNotes;
  final void Function(VoidCallback)? onExpandCallbackReady;
  final String? currentNotes;

  const PatientInfoContainer({
    super.key,
    required this.patient,
    this.onEditNotes,
    this.onExpandCallbackReady,
    this.currentNotes,
  });

  @override
  State<PatientInfoContainer> createState() => _PatientInfoContainerState();
}

class _PatientInfoContainerState extends State<PatientInfoContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
    // Register expand callback with parent
    widget.onExpandCallbackReady?.call(expandContainer);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  // Method to collapse the container programmatically
  void _collapseContainer() {
    if (_isExpanded) {
      setState(() {
        _isExpanded = false;
        _controller.reverse();
      });
    }
  }

  // Method to expand the container programmatically
  void expandContainer() {
    if (!_isExpanded) {
      setState(() {
        _isExpanded = true;
        _controller.forward();
      });
    }
  }

  // Handle edit notes callback
  void _handleEditNotes() {
    _collapseContainer();
    // Wait for animation to complete before showing dialog
    Future.delayed(const Duration(milliseconds: 300), () {
      if (widget.onEditNotes != null) {
        widget.onEditNotes!();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          // Header with collapse button
          InkWell(
            onTap: _toggleExpanded,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
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
                  Expanded(
                    child: Text(
                      widget.patient.name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                  ),
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                    color: Colors.teal[600],
                  ),
                ],
              ),
            ),
          ),
          // Expandable content
          SizeTransition(
            sizeFactor: _animation,
            axisAlignment: -1.0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(),
                  const SizedBox(height: 8),
                  _buildInfoRow(
                    Icons.calendar_today,
                    'Última visita',
                    widget.patient.lastVisit,
                  ),
                  if (widget.patient.birthDate != null)
                    _buildInfoRow(
                      Icons.cake,
                      'Fecha de nacimiento',
                      '${widget.patient.birthDate} (${widget.patient.age} años)',
                    ),
                  if (widget.patient.gender != null)
                    _buildInfoRow(Icons.person, 'Sexo', widget.patient.gender!),
                  if (widget.patient.phone != null)
                    _buildInfoRow(
                      Icons.phone,
                      'Teléfono',
                      widget.patient.phone!,
                    ),
                  if (widget.patient.email != null)
                    _buildInfoRow(Icons.email, 'Email', widget.patient.email!),
                  if (widget.patient.address != null)
                    _buildInfoRow(
                      Icons.location_on,
                      'Dirección',
                      widget.patient.address!,
                    ),
                  // Add notes button if callback is provided
                  if (widget.onEditNotes != null) ...[
                    const SizedBox(height: 8),
                    const Divider(),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: _handleEditNotes,
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.amber[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.amber[200]!,
                            width: 1,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.note_alt_outlined,
                                  size: 20,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Anotaciones importantes',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[800],
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.edit_outlined,
                                  size: 18,
                                  color: Colors.amber[800],
                                ),
                              ],
                            ),
                            if (widget.currentNotes != null &&
                                widget.currentNotes!.isNotEmpty) ...[
                              const SizedBox(height: 8),
                              Text(
                                widget.currentNotes!,
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey[700],
                                  height: 1.4,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ] else ...[
                              const SizedBox(height: 4),
                              Text(
                                'Sin anotaciones',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[500],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: const Color.fromARGB(255, 4, 172, 210)),
          const SizedBox(width: 8),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                children: [
                  TextSpan(
                    text: '$label: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
