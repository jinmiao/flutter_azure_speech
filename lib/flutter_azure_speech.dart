import 'flutter_azure_speech_platform_interface.dart';

class FlutterAzureSpeech {
  Future<String?> getPlatformVersion() {
    return FlutterAzureSpeechPlatform.instance.getPlatformVersion();
  }

  Future<void> initialize(String subscriptionKey, String region) async {
    await FlutterAzureSpeechPlatform.instance
        .initialize(subscriptionKey, region);
  }

  Future<String?> getSpeechToText(String language) {
    return FlutterAzureSpeechPlatform.instance.getSpeechToText(language);
  }
}
