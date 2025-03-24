import 'package:flutter/material.dart';

import 'gen/app_localizations.dart';

export 'gen/app_localizations.dart';

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
      case 'ar':
        return '🇸🇦';
      default:
        return '🏳️';
    }
  }
}