import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Native microphone permission service for iOS
/// Uses AVAudioSession directly to ensure iOS registers permissions correctly
class NativeMicrophoneService {
  static const _channel = MethodChannel('com.fisiomap.pro/microphone');

  /// Request microphone permission using native iOS API
  /// Returns true if granted, false otherwise
  static Future<bool> requestPermission() async {
    // On Android, use permission_handler
    if (!Platform.isIOS) {
      return false; // Android will use permission_handler package
    }

    try {
      final bool granted = await _channel.invokeMethod('requestMicrophonePermission');
      return granted;
    } catch (e) {
      debugPrint('🎤 Error requesting native microphone permission: $e');
      return false;
    }
  }

  /// Check current microphone permission status
  /// Returns: "granted", "denied", or "undetermined"
  static Future<String> checkPermission() async {
    if (!Platform.isIOS) {
      return 'undetermined';
    }

    try {
      final String status = await _channel.invokeMethod('checkMicrophonePermission');
      return status;
    } catch (e) {
      debugPrint('🎤 Error checking native microphone permission: $e');
      return 'undetermined';
    }
  }
}
