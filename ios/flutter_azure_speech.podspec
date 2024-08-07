#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_azure_speech.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_azure_speech'
  s.version          = '0.0.2'
  s.summary          = 'Flutter implementation of Microsoft Azure Speech Speech-To-Text.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  # Add Microsoft Cognitive Services Speech SDK
  s.dependency 'MicrosoftCognitiveServicesSpeech-iOS', '~> 1.37.0'
  s.info_plist = {
    'NSMicrophoneUsageDescription' => 'This app needs access to microphone for speech recognition.'
  }
  s.platform = :ios, '12.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
