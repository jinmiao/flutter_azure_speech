import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_azure_speech_method_channel.dart';

abstract class FlutterAzureSpeechPlatform extends PlatformInterface {
  /// Constructs a FlutterAzureSpeechPlatform.
  FlutterAzureSpeechPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAzureSpeechPlatform _instance =
      MethodChannelFlutterAzureSpeech();

  /// The default instance of [FlutterAzureSpeechPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAzureSpeech].
  static FlutterAzureSpeechPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAzureSpeechPlatform] when
  /// they register themselves.
  static set instance(FlutterAzureSpeechPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initialize(String subscriptionKey, String region) {
    throw UnimplementedError('initialize() has not been implemented.');
  }

  Future<String?> getSpeechToText(String language) {
    throw UnimplementedError('getSpeechToText() has not been implemented.');
  }
}
