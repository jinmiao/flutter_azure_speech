import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_azure_speech/flutter_azure_speech.dart';
import 'package:flutter_azure_speech/flutter_azure_speech_platform_interface.dart';
import 'package:flutter_azure_speech/flutter_azure_speech_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAzureSpeechPlatform
    with MockPlatformInterfaceMixin
    implements FlutterAzureSpeechPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAzureSpeechPlatform initialPlatform = FlutterAzureSpeechPlatform.instance;

  test('$MethodChannelFlutterAzureSpeech is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAzureSpeech>());
  });

  test('getPlatformVersion', () async {
    FlutterAzureSpeech flutterAzureSpeechPlugin = FlutterAzureSpeech();
    MockFlutterAzureSpeechPlatform fakePlatform = MockFlutterAzureSpeechPlatform();
    FlutterAzureSpeechPlatform.instance = fakePlatform;

    expect(await flutterAzureSpeechPlugin.getPlatformVersion(), '42');
  });
}
