package life.aichats.flutter_azure_speech

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.microsoft.cognitiveservices.speech.*

/** FlutterAzureSpeechPlugin */
class FlutterAzureSpeechPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  private var subscriptionKey: String = ""
  private var region: String = ""
  private var language: String = "en-US"

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_azure_speech")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when (call.method) {
      "getPlatformVersion" -> {
        result.success("Android ${android.os.Build.VERSION.RELEASE}")
      }
      "initialize" -> {
        subscriptionKey = call.argument<String>("subscriptionKey")?:""
        region = call.argument<String>("region")?:""
        result.success(true)
      }
      "getSpeechToText" -> {
        language = call.argument<String>("language")?:""
        if (subscriptionKey.isNotEmpty() && region.isNotEmpty()) {
          getSpeechToText(language, result)
        } else {
          result.error("NOT_INITIALIZED", "Plugin not initialized. Call initialize first.", null)
        }
      }
      else -> {
        result.notImplemented()
      }
    }
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun getSpeechToText(language: String, result: Result) {
    try {
      val config = SpeechConfig.fromSubscription(subscriptionKey, region)
      config.speechRecognitionLanguage = language
      val recognizer = SpeechRecognizer(config)

      val eventResult = recognizer.recognizeOnceAsync().get()
      result.success(eventResult.text)
      recognizer.close()
    } catch (ex: Exception) {
      result.error("RECOGNITION_ERROR", ex.message, null)
    }
  }
}
