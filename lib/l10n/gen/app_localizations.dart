import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru')
  ];

  /// No description provided for @missing.
  ///
  /// In en, this message translates to:
  /// **'Token is missing. Authorize.'**
  String get missing;

  /// No description provided for @operationSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Operation successful!'**
  String get operationSuccessful;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @operationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to complete operation.'**
  String get operationFailed;

  /// No description provided for @loginSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Login successful!'**
  String get loginSuccessful;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed.'**
  String get loginFailed;

  /// No description provided for @logoutSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Logged out successfully.'**
  String get logoutSuccessful;

  /// No description provided for @pixel.
  ///
  /// In en, this message translates to:
  /// **'Pixel'**
  String get pixel;

  /// No description provided for @pixelChange.
  ///
  /// In en, this message translates to:
  /// **'color changed to'**
  String get pixelChange;

  /// No description provided for @warningPixel.
  ///
  /// In en, this message translates to:
  /// **'Please enter a pixel number between 1 and 22.'**
  String get warningPixel;

  /// No description provided for @applyPixel.
  ///
  /// In en, this message translates to:
  /// **'Apply Pixel Color'**
  String get applyPixel;

  /// No description provided for @mainPage.
  ///
  /// In en, this message translates to:
  /// **'Control Page'**
  String get mainPage;

  /// No description provided for @selectedColor.
  ///
  /// In en, this message translates to:
  /// **'Selected Color'**
  String get selectedColor;

  /// No description provided for @offEffect.
  ///
  /// In en, this message translates to:
  /// **'Off Effect'**
  String get offEffect;

  /// No description provided for @effectChange.
  ///
  /// In en, this message translates to:
  /// **'Effect'**
  String get effectChange;

  /// No description provided for @toggleOn.
  ///
  /// In en, this message translates to:
  /// **'Toggle On'**
  String get toggleOn;

  /// No description provided for @toggleOff.
  ///
  /// In en, this message translates to:
  /// **'Toggle Off'**
  String get toggleOff;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @userName.
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get userName;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'LED control'**
  String get appTitle;

  /// No description provided for @entranceError.
  ///
  /// In en, this message translates to:
  /// **'Login Error. Check login and password'**
  String get entranceError;

  /// No description provided for @voiceTurnOn.
  ///
  /// In en, this message translates to:
  /// **'turn on'**
  String get voiceTurnOn;

  /// No description provided for @voiceTurnOff.
  ///
  /// In en, this message translates to:
  /// **'turn off'**
  String get voiceTurnOff;

  /// No description provided for @voiceBrightness.
  ///
  /// In en, this message translates to:
  /// **'brightness'**
  String get voiceBrightness;

  /// No description provided for @voiceEffect.
  ///
  /// In en, this message translates to:
  /// **'effect'**
  String get voiceEffect;

  /// No description provided for @voiceDisableEffect.
  ///
  /// In en, this message translates to:
  /// **'effect off'**
  String get voiceDisableEffect;

  /// No description provided for @voicePixel.
  ///
  /// In en, this message translates to:
  /// **'pixel'**
  String get voicePixel;

  /// No description provided for @voiceRed.
  ///
  /// In en, this message translates to:
  /// **'red'**
  String get voiceRed;

  /// No description provided for @voiceGreen.
  ///
  /// In en, this message translates to:
  /// **'green'**
  String get voiceGreen;

  /// No description provided for @voiceBlue.
  ///
  /// In en, this message translates to:
  /// **'blue'**
  String get voiceBlue;

  /// No description provided for @voiceYellow.
  ///
  /// In en, this message translates to:
  /// **'yellow'**
  String get voiceYellow;

  /// No description provided for @voiceWhite.
  ///
  /// In en, this message translates to:
  /// **'white'**
  String get voiceWhite;

  /// No description provided for @voiceControl.
  ///
  /// In en, this message translates to:
  /// **'Voice control'**
  String get voiceControl;

  /// No description provided for @voiceControlOff.
  ///
  /// In en, this message translates to:
  /// **'Off voice control'**
  String get voiceControlOff;

  /// No description provided for @voiceControlEnabled.
  ///
  /// In en, this message translates to:
  /// **'Voice control enable!'**
  String get voiceControlEnabled;

  /// No description provided for @disableVoiceControl.
  ///
  /// In en, this message translates to:
  /// **'Voice control disable'**
  String get disableVoiceControl;

  /// No description provided for @voiceExit.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get voiceExit;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ru': return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
