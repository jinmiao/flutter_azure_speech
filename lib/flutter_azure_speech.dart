import 'flutter_azure_speech_platform_interface.dart';

/// An implementation of [FlutterAzureSpeechPlatform] that uses method channels.
class FlutterAzureSpeech {
  /// A method channel `FlutterAzureSpeech` instance.
  Future<String?> getPlatformVersion() {
    return FlutterAzureSpeechPlatform.instance.getPlatformVersion();
  }

  /// A method channel `FlutterAzureSpeech` instance.
  Future<void> initialize(String subscriptionKey, String region) async {
    await FlutterAzureSpeechPlatform.instance
        .initialize(subscriptionKey, region);
  }

  /// A method channel `FlutterAzureSpeech` instance.
  Future<String?> getSpeechToText(String language) {
    return FlutterAzureSpeechPlatform.instance.getSpeechToText(language);
  }
}
