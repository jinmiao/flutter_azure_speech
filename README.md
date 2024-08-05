# flutter_azure_speech

Flutter implementation of [Microsoft Azure Speech service](https://learn.microsoft.com/en-us/azure/ai-services/speech-service/)

 - Speech to Text [Done]
 - Text to Speech [InProgress]

## Getting Started

Initialise the framework with your Region and Subscription key

```dart
Future<void> _initializeSpeechRecognition() async {
    try {
      await _flutterAzureSpeechPlugin.initialize(
          "YOUR SUBSCRIPTION KEY", "YOUR REGION");
    } catch (e) {
      print('Error initializing speech recognition: $e');
    }
  }
```

## Speech to Text

Start the speech recognition process by calling the `getSpeechToText` method.

```dart
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
```

## Text to Speech

[InProgress]

## 示例截图

![Android示例截图](images/android_demo.jpg){ width=300 }