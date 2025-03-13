import 'package:speech_to_text/speech_to_text.dart' as stt;

class VoiceApi {
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isAvailable = false;
  bool _isListening = false;

  Future<void> init() async {
    _isAvailable = await _speech.initialize();
  }

  void startListening(Function(String) onResult) {
    if (!_isAvailable || _isListening) return;

    _speech.listen(
      onResult: (result) => onResult(result.recognizedWords),
      listenFor: const Duration(seconds: 5),
    );
    _isListening = true;
  }

  void stopListening() {
    _speech.stop();
    _isListening = false;
  }
}
