import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_azure_speech/flutter_azure_speech.dart';

import 'config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _recognizedText = '';
  final _flutterAzureSpeechPlugin = FlutterAzureSpeech();

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _initializeSpeechRecognition();
  }

  Future<void> _initializeSpeechRecognition() async {
    try {
      await _flutterAzureSpeechPlugin.initialize(
          AppConstants.subscriptionKey, AppConstants.region);
    } catch (e) {
      print('Error initializing speech recognition: $e');
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _flutterAzureSpeechPlugin.getPlatformVersion() ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Speech to Text Demo'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _platformVersion,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  _recognizedText,
                  style: TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              ElevatedButton(
                child: Text('Start Speech Recognition'),
                onPressed: _startSpeechRecognition,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _startSpeechRecognition() async {
    try {
      setState(() {
        _recognizedText = "Listening...";
      });

      String recognizedText =
          await _flutterAzureSpeechPlugin.getSpeechToText("zh-CN") ?? "";

      setState(() {
        _recognizedText = recognizedText;
      });
    } catch (e) {
      print('Error during speech recognition: $e');

      setState(() {
        _recognizedText = "An error occurred during speech recognition.";
      });
    }
  }
}
