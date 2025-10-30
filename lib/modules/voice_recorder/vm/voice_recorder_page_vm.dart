import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screens_fisiomap/services/native_microphone_service.dart';

/// ViewModel for VoiceRecorderPage
class VoiceRecorderPageViewModel extends BaseVM {
  final AudioRecorder _audioRecorder = AudioRecorder();
  
  // Recording state
  bool _isRecording = false;
  bool get isRecording => _isRecording;
  
  bool _isPaused = false;
  bool get isPaused => _isPaused;
  
  // Recording duration
  int _recordingDuration = 0;
  int get recordingDuration => _recordingDuration;
  
  Timer? _timer;
  String? _recordingPath;
  
  // Permission state
  bool _hasPermission = false;
  bool get hasPermission => _hasPermission;

  @override
  void dispose() {
    _timer?.cancel();
    _audioRecorder.dispose();
    super.dispose();
  }

  // Initialize and check permissions
  Future<void> onInit() async {
    await _checkPermission();
  }

  // Check microphone permission status (don't request yet)
  Future<void> _checkPermission() async {
    setBusy(true);
    
    if (Platform.isIOS) {
      // Use native iOS method for more reliable permission handling
      final nativeStatus = await NativeMicrophoneService.checkPermission();
      _hasPermission = nativeStatus == 'granted';
      debugPrint('🎤 Native iOS permission status: $nativeStatus');
    } else {
      // Use permission_handler for Android
      final status = await Permission.microphone.status;
      _hasPermission = status.isGranted;
      debugPrint('🎤 Android permission status: $status');
    }
    
    debugPrint('🎤 Has permission: $_hasPermission');
    setBusy(false);
    notifyListeners();
  }

  /// Public method to (re)request microphone permission on user action.
  /// Returns the resulting [PermissionStatus].
  Future<PermissionStatus> requestPermission() async {
    debugPrint('🎤 Requesting microphone permission...');
    setBusy(true);
    
    PermissionStatus result;
    
    if (Platform.isIOS) {
      // Use native iOS AVAudioSession for reliable permission prompt
      final granted = await NativeMicrophoneService.requestPermission();
      debugPrint('🎤 Native iOS permission granted: $granted');
      _hasPermission = granted;
      // Convert to PermissionStatus for compatibility
      result = granted ? PermissionStatus.granted : PermissionStatus.denied;
    } else {
      // Use permission_handler for Android
      result = await Permission.microphone.request();
      debugPrint('🎤 Android permission result: $result');
      _hasPermission = result.isGranted;
    }
    
    setBusy(false);
    notifyListeners();
    return result;
  }

  // Start recording - returns PermissionStatus if permission was denied
  Future<PermissionStatus?> startRecording() async {
    // Request permission if not granted
    if (!_hasPermission) {
      debugPrint('🎤 No permission yet, requesting...');
      final status = await requestPermission();
      if (!status.isGranted) {
        debugPrint('🎤 Permission denied: $status');
        return status; // Return status so UI can handle it
      }
    }

    try {
      // Get temporary directory for recording
      final directory = await getTemporaryDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _recordingPath = '${directory.path}/recording_$timestamp.m4a';

      debugPrint('🎤 Starting recording at: $_recordingPath');
      
      // Start recording
      await _audioRecorder.start(
        const RecordConfig(
          encoder: AudioEncoder.aacLc,
          bitRate: 128000,
          sampleRate: 44100,
        ),
        path: _recordingPath!,
      );

      _isRecording = true;
      _isPaused = false;
      _recordingDuration = 0;
      
      // Start timer
      _startTimer();
      
      notifyListeners();
      debugPrint('🎤 Recording started successfully');
      return null; // Success, no permission issue
    } catch (e) {
      debugPrint('🎤 Error starting recording: $e');
      return null;
    }
  }

  // Pause recording
  Future<void> pauseRecording() async {
    if (!_isRecording) return;

    try {
      await _audioRecorder.pause();
      _isPaused = true;
      _timer?.cancel();
      notifyListeners();
      debugPrint('Recording paused');
    } catch (e) {
      debugPrint('Error pausing recording: $e');
    }
  }

  // Resume recording
  Future<void> resumeRecording() async {
    if (!_isRecording || !_isPaused) return;

    try {
      await _audioRecorder.resume();
      _isPaused = false;
      _startTimer();
      notifyListeners();
      debugPrint('Recording resumed');
    } catch (e) {
      debugPrint('Error resuming recording: $e');
    }
  }

  // Stop recording
  Future<String?> stopRecording() async {
    if (!_isRecording) return null;

    try {
      final path = await _audioRecorder.stop();
      _isRecording = false;
      _isPaused = false;
      _timer?.cancel();
      notifyListeners();
      
      debugPrint('Recording stopped: $path');
      return path;
    } catch (e) {
      debugPrint('Error stopping recording: $e');
      return null;
    }
  }

  // Cancel recording
  Future<void> cancelRecording() async {
    if (!_isRecording) return;

    try {
      await _audioRecorder.stop();
      _isRecording = false;
      _isPaused = false;
      _recordingDuration = 0;
      _timer?.cancel();
      notifyListeners();
      debugPrint('Recording cancelled');
    } catch (e) {
      debugPrint('Error cancelling recording: $e');
    }
  }

  // Start timer to track duration
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _recordingDuration++;
      notifyListeners();
    });
  }

  // Format duration as MM:SS
  String get formattedDuration {
    final minutes = (_recordingDuration ~/ 60).toString().padLeft(2, '0');
    final seconds = (_recordingDuration % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
