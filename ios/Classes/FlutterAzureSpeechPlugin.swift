import Flutter
import UIKit

public class FlutterAzureSpeechPlugin: NSObject, FlutterPlugin {
  private var subscriptionKey: String?
  private var region: String?
  private var language: String = "en-US"

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_azure_speech", binaryMessenger: registrar.messenger())
    let instance = FlutterAzureSpeechPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "initialize":
      guard let args = call.arguments as? [String: Any],
            let subscriptionKey = args["subscriptionKey"] as? String,
            let region = args["region"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments", details: nil))
        return
      }
      self.subscriptionKey = subscriptionKey
      self.region = region
      result(nil)
    case "getSpeechToText":
      guard let subscriptionKey = self.subscriptionKey, let region = self.region else {
        result(FlutterError(code: "NOT_INITIALIZED", message: "Plugin not initialized. Call initialize first.", details: nil))
        return
      }
      guard let args = call.arguments as? [String: Any],
            let language = args["language"] as? String else {
        result(FlutterError(code: "INVALID_ARGUMENT", message: "Invalid arguments. No language set.", details: nil))
        return
      }
      getSpeechToText(subscriptionKey: subscriptionKey, region: region, language: language, result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func getSpeechToText(subscriptionKey: String, region: String, language: String, result: @escaping FlutterResult) {
    requestMicrophonePermission { granted in
      if granted {
        let speechConfig = try! SpeechConfig(subscription: subscriptionKey, region: region)
        speechConfig.speechRecognitionLanguage = language
        let audioConfig = AudioConfig()
        let recognizer = try! SpeechRecognizer(speechConfig: speechConfig, audioConfig: audioConfig)

        recognizer.recognizeOnce { (outcome) in
          switch outcome {
          case .success(let recognitionResult):
            result(recognitionResult.text)
          case .failure(let error):
            result(FlutterError(code: "RECOGNITION_ERROR", message: error.localizedDescription, details: nil))
          }
        }
      } else {
        result(FlutterError(code: "PERMISSION_DENIED", message: "Microphone permission denied", details: nil))
      }
    }
  }

  private func requestMicrophonePermission(completion: @escaping (Bool) -> Void) {
    AVAudioSession.sharedInstance().requestRecordPermission { granted in
      DispatchQueue.main.async {
        completion(granted)
      }
    }
  }
}
