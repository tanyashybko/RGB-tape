import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceApi {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;
  bool _isListening = false;

  Future<void> init() async {
    _isAvailable = await _speech.initialize(
      onStatus: (status) {
        if (kDebugMode) print("Speech status: $status");

        if (status == "done" && _isListening) {
          if (kDebugMode) print("Restarting listening...");
          Future.delayed(const Duration(milliseconds: 500), () {
            if (_isListening) startListening((text) => print("Recognized: $text"));
          });
        }
      },
      onError: (error) {
        if (kDebugMode) print("Speech error: $error");
        stopListening();

        Future.delayed(const Duration(seconds: 1), () {
          if (_isListening) startListening((text) => print("Recognized: $text"));
        });
      },
    );

      var availableLocales = await _speech.locales();
      for (var locale in availableLocales) {
        print('Available locale: ${locale.localeId}');
      }
  }

  void startListening(Function(String) onResult, {String localeId = 'ru_RU'}) {
    if (!_isAvailable || _isListening) return;

    _isListening = true;
    if (kDebugMode) {
      print("Voice listening started with locale: $localeId");
    }

    _speech.listen(
      onResult: (result) {
        onResult(result.recognizedWords);
        if (kDebugMode) {
          print("Recognized: ${result.recognizedWords}");
        }
      },
      listenMode: stt.ListenMode.dictation,
      cancelOnError: false,
      onSoundLevelChange: (level) => print("Sound level: $level"),
      localeId: localeId,
    );
  }

  void dispose() {
    _speech.stop();
    _speech.cancel();
    _isListening = false;
    if (kDebugMode) print("VoiceApi disposed");
  }

  void stopListening() {
    _isListening = false;
    _speech.stop();
    if (kDebugMode) {
      print("Voice listening stopped");
    }
  }
}

