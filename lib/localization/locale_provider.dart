import 'package:flutter/material.dart';
// import 'package:audioplayers/audioplayers.dart';
import '../l10n/l10n.dart';

class LocaleProvider extends ChangeNotifier {
  Locale? _locale;
  // final AudioPlayer _player = AudioPlayer();

  Locale? get locale => _locale;

  void setLocale(Locale locale) async {
    if (!AppLocalizations.supportedLocales.contains(locale)) return;

    _locale = locale;
    notifyListeners();

    // if (locale.languageCode == 'ar') {
    //   await _player.play(AssetSource('arabic_song.mp3'));
    // } else {
    //   await _player.stop();
    // }
  }

  void clearLocale() {
    _locale = null;
    notifyListeners();
  }
}
