import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceApi {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;
  bool _isListening = false;

  Future<void> init() async {
    _isAvailable = await _speech.initialize(
      onStatus: (status) {
        if (kDebugMode) {
          print("Speech status: $status");
        }
        if (status == "done" && _isListening) {
          if (kDebugMode) {
            print("Restarting listening...");
          }
          startListening((text) => print("Recognized: $text"));
        }
      },
      onError: (error) {
        if (kDebugMode) {
          print("Speech error: $error");
        }
      },
    );
  }

  void startListening(Function(String) onResult) {
    if (!_isAvailable || _isListening) return;

    _isListening = true;
    if (kDebugMode) {
      print("Voice listening started");
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
    );
  }

  void stopListening() {
    _isListening = false;
    _speech.stop();
    if (kDebugMode) {
      print("Voice listening stopped");
    }
  }
}
