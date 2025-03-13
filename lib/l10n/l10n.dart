import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
export 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension AppLocalizationsX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);
}

class L10n {
  static String getFlag(String code) {
    switch (code) {
      case 'en':
        return '🇺🇸';
      case 'ru':
        return '🇷🇺';
      default:
        return '🏳️';
    }
  }
}