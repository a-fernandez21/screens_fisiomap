import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:pumpun_core/pumpun_core.dart';
import 'package:screens_fisiomap/models/patient.dart';

/// ViewModel for RecordSessionPage.
///
/// Manages:
/// - Audio player state (play/pause simulation)
/// - Text editing state
/// - Session actions (save changes, confirm review)
/// - Navigation with result return
class RecordSessionPageViewModel extends BaseVM {
  // Final fields
  final Patient patient;
  final String sessionType;
  final int? recordId;
  final String? audioPath;
  final String? consultationType;

  // Text controller for editable notes
  final TextEditingController textController = TextEditingController();

  // Audio player instance
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Private state variables with getters and setters immediately below
  /// Check for correct implementation of saved recording api call
  bool _isRecordingSaved = false;
  bool get isRecordingSaved => _isRecordingSaved;
  set isRecordingSaved(bool value) {
    _isRecordingSaved = value;
    notifyListeners();
  }

  bool _isPlaying = false;
  bool get isPlaying => _isPlaying;
  set isPlaying(bool value) {
    _isPlaying = value;
    notifyListeners();
  }

  String _audioStatus = 'Sin audio';
  String get audioStatus => _audioStatus;
  set audioStatus(String value) {
    _audioStatus = value;
    notifyListeners();
  }

  bool _isEditing = false;
  bool get isEditing => _isEditing;
  set isEditing(bool value) {
    _isEditing = value;
    notifyListeners();
  }

  String _htmlContent = '';
  String get htmlContent => _htmlContent;
  set htmlContent(String value) {
    _htmlContent = value;
    notifyListeners();
  }

  bool _isEditorFocused = false;
  bool get isEditorFocused => _isEditorFocused;
  set isEditorFocused(bool value) {
    _isEditorFocused = value;
    notifyListeners();
  }

  Duration _currentPosition = Duration.zero;
  Duration get currentPosition => _currentPosition;
  set currentPosition(Duration value) {
    _currentPosition = value;
    notifyListeners();
  }

  Duration _totalDuration = Duration.zero;
  Duration get totalDuration => _totalDuration;
  set totalDuration(Duration value) {
    _totalDuration = value;
    notifyListeners();
  }

  RecordSessionPageViewModel({
    required this.patient,
    required this.sessionType,
    this.recordId,
    this.audioPath,
    this.consultationType,
  });

  /// Initialize the ViewModel with default text.
  /// Called from BaseWidget's onModelReady
  Future<void> onInit() async {
    debugPrint('🎬 RecordSessionPageViewModel.onInit() called');
    debugPrint('📍 audioPath received: $audioPath');
    debugPrint('📍 recordId: $recordId');
    debugPrint('📍 sessionType: $sessionType');
    debugPrint('📍 consultationType: $consultationType');

    // Build initial text with consultation type if provided
    String initialText =
        'Haz clic aquí para empezar a escribir las notas de la sesión...';
    if (consultationType != null && sessionType == 'Seguimiento') {
      initialText = 'Tipo de consulta: $consultationType\n\n$initialText';
    }
    textController.text = initialText;

    // Initialize audio player
    await _initializeAudioPlayer();
  }

  /// Initialize audio player with listeners
  Future<void> _initializeAudioPlayer() async {
    try {
      // Load audio from recorded file or default asset
      if (audioPath != null && audioPath!.isNotEmpty) {
        // Verify file exists before loading
        final audioFile = File(audioPath!);
        final fileExists = await audioFile.exists();
        debugPrint('🎵 Checking audio file: $audioPath');
        debugPrint('🎵 File exists: $fileExists');

        if (fileExists) {
          // Load recorded audio from device path
          await _audioPlayer.setSourceDeviceFile(audioPath!);
          debugPrint('🎵 Recorded audio loaded successfully');
        } else {
          debugPrint('❌ Audio file not found, loading default');
          await _audioPlayer.setSource(AssetSource('audio-prueba-hc.mp3'));
        }
      } else {
        // Load default audio from assets
        await _audioPlayer.setSource(AssetSource('audio-prueba-hc.mp3'));
        debugPrint('🎵 No audioPath provided, loading default audio');
      }

      // Listen to player state changes
      _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
        if (!disposed) {
          isPlaying = state == PlayerState.playing;
          audioStatus =
              state == PlayerState.playing
                  ? 'Reproduciendo...'
                  : state == PlayerState.paused
                  ? 'Pausado'
                  : 'Detenido';
          debugPrint('🎵 Player state changed: $state, isPlaying: $isPlaying');
        }
      });

      // Listen to duration changes
      _audioPlayer.onDurationChanged.listen((Duration duration) {
        if (!disposed) {
          totalDuration = duration;
          debugPrint('📊 Audio duration: ${duration.inSeconds}s');
        }
      });

      // Listen to position changes
      _audioPlayer.onPositionChanged.listen((Duration position) {
        if (!disposed) {
          currentPosition = position;
        }
      });

      audioStatus = 'Audio cargado';
      debugPrint('🎵 Audio player initialized successfully');
    } catch (e) {
      debugPrint('❌ Error initializing audio player: $e');
      audioStatus = 'Error al cargar audio';
    }
  }

  /// Toggle play/pause audio playback.
  void togglePlayPause() async {
    try {
      debugPrint('🎵 togglePlayPause called, current isPlaying: $isPlaying');
      if (isPlaying) {
        await _audioPlayer.pause();
        debugPrint('⏸️ Audio paused');
      } else {
        // Resume playback of already loaded audio source
        await _audioPlayer.resume();
        debugPrint('▶️ Audio playing (source already loaded)');
      }
    } catch (e) {
      debugPrint('❌ Error toggling audio: $e');
      audioStatus = 'Error de reproducción';
    }
  }

  /// Rewind audio by 10 seconds
  void rewind10Seconds() async {
    try {
      final newPosition = currentPosition - const Duration(seconds: 10);
      await _audioPlayer.seek(
        newPosition < Duration.zero ? Duration.zero : newPosition,
      );
      debugPrint('⏪ Rewound 10 seconds');
    } catch (e) {
      debugPrint('❌ Error rewinding: $e');
    }
  }

  /// Forward audio by 10 seconds
  void forward10Seconds() async {
    try {
      final newPosition = currentPosition + const Duration(seconds: 10);
      await _audioPlayer.seek(
        newPosition > totalDuration ? totalDuration : newPosition,
      );
      debugPrint('⏩ Forwarded 10 seconds');
    } catch (e) {
      debugPrint('❌ Error forwarding: $e');
    }
  }

  /// Skip to previous track (restart current audio)
  void skipToPrevious() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      debugPrint('⏮️ Skipped to start');
    } catch (e) {
      debugPrint('❌ Error skipping to previous: $e');
    }
  }

  /// Skip to next track (restart current audio for now)
  void skipToNext() async {
    try {
      await _audioPlayer.seek(Duration.zero);
      debugPrint('⏭️ Skipped to next (restart)');
    } catch (e) {
      debugPrint('❌ Error skipping to next: $e');
    }
  }

  /// Handle text field tap to start editing.
  void onTextFieldTap() {
    isEditing = true;
    if (textController.text ==
        'Haz clic aquí para empezar a escribir las notas de la sesión...') {
      textController.clear();
    }
  }

  /// Handle HTML content changes from the editor
  void onHtmlContentChanged(String content) {
    htmlContent = content;
    debugPrint('📝 HTML content updated: ${content.length} characters');
  }

  /// Handle when HTML editor gains focus
  void onEditorFocused() {
    isEditorFocused = true;
    debugPrint('🎯 Editor focused - hiding audio player');
  }

  /// Handle when HTML editor loses focus
  void onEditorUnfocused() {
    isEditorFocused = false;
    debugPrint('🎯 Editor unfocused - showing audio player');
  }

  /// Save HTML content
  Future<bool> saveHtmlContent() async {
    debugPrint('💾 Saving HTML content: ${htmlContent.length} characters');
    try {
      // In a real app, this would save to a file or send to server
      // For now, we'll simulate success
      await Future.delayed(const Duration(milliseconds: 500));
      isRecordingSaved = true;
      return true;
    } catch (e) {
      debugPrint('❌ Error saving HTML content: $e');
      return false;
    }
  }

  /// Save changes and return result.
  /// Returns true if saved successfully, false otherwise.
  Future<bool> saveChanges() async {
    debugPrint('💾 Botón Guardar Cambios presionado');
    // API call to save
    if (isRecordingSaved) {
      return true;
    } else {
      return false;
    }
  }

  /// Confirm review and return 'Completado' status.
  /// Returns the status string to be used by the view for navigation.
  String confirmReview() {
    debugPrint('✅ Botón Confirmar Revisión presionado');
    debugPrint('🚪 Devolviendo estado: Completado');
    return 'Completado';
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    textController.dispose();
    super.dispose();
  }
}
