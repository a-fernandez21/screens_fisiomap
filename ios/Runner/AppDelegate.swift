import Flutter
import UIKit
import AVFoundation

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    
    // Setup native microphone permission channel
    let controller = window?.rootViewController as! FlutterViewController
    let microphoneChannel = FlutterMethodChannel(
      name: "com.fisiomap.pro/microphone",
      binaryMessenger: controller.binaryMessenger
    )
    
    microphoneChannel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      switch call.method {
      case "requestMicrophonePermission":
        self?.requestMicrophonePermission(result: result)
      case "checkMicrophonePermission":
        self?.checkMicrophonePermission(result: result)
      default:
        result(FlutterMethodNotImplemented)
      }
    }
    
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  // Request microphone permission using native AVAudioSession
  private func requestMicrophonePermission(result: @escaping FlutterResult) {
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
      DispatchQueue.main.async {
        result(granted)
      }
    }
  }
  
  // Check current microphone permission status
  private func checkMicrophonePermission(result: @escaping FlutterResult) {
    let status = AVAudioSession.sharedInstance().recordPermission
    switch status {
    case .granted:
      result("granted")
    case .denied:
      result("denied")
    case .undetermined:
      result("undetermined")
    @unknown default:
      result("undetermined")
    }
  }
}
