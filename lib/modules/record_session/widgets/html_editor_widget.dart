import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import '../services/html_file_service.dart';

/// HTML Editor widget for editing medical record content with rich text formatting
class HtmlEditorWidget extends StatefulWidget {
  final Function(String) onContentChanged;
  final VoidCallback? onSave;
  final VoidCallback? onFocused;
  final VoidCallback? onUnfocused;

  const HtmlEditorWidget({
    super.key,
    required this.onContentChanged,
    this.onSave,
    this.onFocused,
    this.onUnfocused,
  });

  @override
  State<HtmlEditorWidget> createState() => _HtmlEditorWidgetState();
}

class _HtmlEditorWidgetState extends State<HtmlEditorWidget> {
  final HtmlEditorController _controller = HtmlEditorController();
  bool _isLoading = true;
  String _initialContent = '';

  @override
  void initState() {
    super.initState();
    _loadHtmlContent();
  }

  Future<void> _loadHtmlContent() async {
    debugPrint('🚀 Starting HTML content load...');
    try {
      final htmlContent = await HtmlFileService.loadHtmlContent();
      debugPrint(
        '✅ HTML Content received in widget: ${htmlContent.length} characters',
      );
      debugPrint(
        '✅ Content starts with: ${htmlContent.substring(0, htmlContent.length > 100 ? 100 : htmlContent.length)}',
      );

      if (mounted) {
        setState(() {
          _initialContent = htmlContent;
          _isLoading = false;
        });
        debugPrint('✅ Widget state updated successfully');
      }
    } catch (e, stackTrace) {
      debugPrint('❌ CRITICAL ERROR loading HTML: $e');
      debugPrint('❌ Stack trace: $stackTrace');

      if (mounted) {
        setState(() {
          _initialContent =
              '<h1>ERROR: No se pudo cargar el archivo HTML</h1><p>Error: $e</p><p>StackTrace: $stackTrace</p>';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(color: Colors.teal),
            SizedBox(height: 16),
            Text(
              'Cargando documento médico...',
              style: TextStyle(color: Colors.teal, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade300),
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
        children: [
          // Header with icon and title
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.teal[50],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.medical_information,
                  color: Colors.teal[600],
                  size: 24,
                ),
                const SizedBox(width: 12),
                Text(
                  'Història Clínica de Fisioteràpia',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const Spacer(),
                if (widget.onSave != null)
                  IconButton(
                    onPressed: widget.onSave,
                    icon: const Icon(Icons.save, color: Colors.teal),
                    tooltip: 'Guardar cambios',
                  ),
              ],
            ),
          ),
          // HTML Editor
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: SizedBox(
                  height: 400,
                  child: HtmlEditor(
                    controller: _controller,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: 'Edita el contenido de la história clínica...',
                      initialText: _initialContent,
                      shouldEnsureVisible: true,
                      adjustHeightForKeyboard: true,
                      spellCheck: true,
                      autoAdjustHeight: false,
                    ),
                    htmlToolbarOptions: HtmlToolbarOptions(
                      toolbarPosition: ToolbarPosition.aboveEditor,
                      toolbarType: ToolbarType.nativeGrid,
                      defaultToolbarButtons: [
                        const StyleButtons(style: true),
                        const FontSettingButtons(fontSize: true),
                        const FontButtons(
                          bold: true,
                          italic: true,
                          underline: true,
                          clearAll: false,
                          strikethrough: false,
                          superscript: false,
                          subscript: false,
                        ),
                        const ColorButtons(
                          foregroundColor: true,
                          highlightColor: true,
                        ),
                        const ListButtons(
                          ul: true,
                          ol: true,
                          listStyles: false,
                        ),
                        const ParagraphButtons(
                          textDirection: false,
                          lineHeight: false,
                          caseConverter: false,
                          alignCenter: true,
                          alignJustify: true,
                          alignLeft: true,
                          alignRight: true,
                          increaseIndent: true,
                          decreaseIndent: true,
                        ),
                        const InsertButtons(
                          link: true,
                          picture: false,
                          audio: false,
                          video: false,
                          otherFile: false,
                          table: true,
                          hr: true,
                        ),
                        const OtherButtons(
                          fullscreen: false,
                          codeview: true,
                          undo: true,
                          redo: true,
                          help: false,
                        ),
                      ],
                    ),
                    otherOptions: const OtherOptions(
                      height: 400,
                      decoration: BoxDecoration(
                        border: Border.fromBorderSide(
                          BorderSide(color: Colors.grey, width: 1),
                        ),
                      ),
                    ),
                    callbacks: Callbacks(
                      onChangeContent: (String? content) {
                        if (content != null) {
                          widget.onContentChanged(content);
                        }
                      },
                      onInit: () {
                        debugPrint('🎯 HTML Editor initialized');
                        debugPrint(
                          '🎯 Current _initialContent length: ${_initialContent.length}',
                        );
                        debugPrint(
                          '🎯 Content preview: ${_initialContent.length > 50 ? _initialContent.substring(0, 50) : _initialContent}...',
                        );

                        // Multiple attempts to force content load
                        Future.delayed(const Duration(milliseconds: 200), () {
                          if (_initialContent.isNotEmpty) {
                            debugPrint(
                              '🔥 Attempt 1: Setting content (${_initialContent.length} chars)',
                            );
                            _controller.setText(_initialContent);
                          }
                        });

                        Future.delayed(const Duration(milliseconds: 1000), () {
                          if (_initialContent.isNotEmpty) {
                            debugPrint(
                              '🔥 Attempt 2: Setting content (${_initialContent.length} chars)',
                            );
                            _controller.setText(_initialContent);
                          }
                        });

                        Future.delayed(const Duration(milliseconds: 2000), () {
                          if (_initialContent.isNotEmpty) {
                            debugPrint(
                              '🔥 Attempt 3: Setting content (${_initialContent.length} chars)',
                            );
                            _controller.setText(_initialContent);
                          }
                        });
                      },
                      onFocus: () {
                        widget.onFocused?.call();
                      },
                      onBlur: () {
                        widget.onUnfocused?.call();
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // HtmlEditorController doesn't need explicit disposal
    super.dispose();
  }
}
