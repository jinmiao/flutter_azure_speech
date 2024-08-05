import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'flutter_azure_speech_platform_interface.dart';

/// An implementation of [FlutterAzureSpeechPlatform] that uses method channels.
class MethodChannelFlutterAzureSpeech extends FlutterAzureSpeechPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_azure_speech');

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<void> initialize(String subscriptionKey, String region) async {
    await methodChannel.invokeMethod<String>('initialize', {
      'subscriptionKey': subscriptionKey,
      'region': region,
    });
  }

  @override
  Future<String?> getSpeechToText(String language) async {
    final speechToText = await methodChannel.invokeMethod<String>(
      'getSpeechToText',
      {'language': language},
    );
    return speechToText;
  }
}
