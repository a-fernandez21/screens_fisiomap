import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service to handle HTML file operations for medical record editing
class HtmlFileService {
  static const String _htmlFilePath = 'lib/data/File.html';

  /// Loads the HTML content from the File.html
  static Future<String> loadHtmlContent() async {
    debugPrint('🔍 Attempting to load file: $_htmlFilePath');
    try {
      // ALWAYS load the actual file, no fallbacks, no processing
      final String htmlContent = await rootBundle.loadString(_htmlFilePath);
      debugPrint(
        '✅ SUCCESSFULLY LOADED FILE: ${htmlContent.length} characters',
      );
      debugPrint(
        '✅ FILE STARTS WITH: ${htmlContent.substring(0, htmlContent.length > 200 ? 200 : htmlContent.length)}',
      );
      return htmlContent;
    } catch (e, stackTrace) {
      debugPrint('❌ FAILED TO LOAD FILE: $e');
      debugPrint('❌ Stack trace: $stackTrace');
      rethrow; // Re-throw to let widget handle it
    }
  }

  /// Saves HTML content (in a real app, this would write to a file)
  /// For now, we'll just return success as we can't write to assets
  static Future<bool> saveHtmlContent(String htmlContent) async {
    try {
      // In a real implementation, this would save to a writable location
      // For demo purposes, we'll just return true
      return true;
    } catch (e) {
      return false;
    }
  }
}
