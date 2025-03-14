// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get missing => 'Token is missing. Authorize.';

  @override
  String get operationSuccessful => 'Operation successful!';

  @override
  String get error => 'Error';

  @override
  String get operationFailed => 'Failed to complete operation.';

  @override
  String get loginSuccessful => 'Login successful!';

  @override
  String get loginFailed => 'Login failed.';

  @override
  String get logoutSuccessful => 'Logged out successfully.';

  @override
  String get pixel => 'Pixel';

  @override
  String get pixelChange => 'color changed to';

  @override
  String get warningPixel => 'Please enter a pixel number between 1 and 22.';

  @override
  String get applyPixel => 'Apply Pixel Color';

  @override
  String get mainPage => 'Control Page';

  @override
  String get selectedColor => 'Selected Color';

  @override
  String get offEffect => 'Off Effect';

  @override
  String get effectChange => 'Effect';

  @override
  String get toggleOn => 'Toggle On';

  @override
  String get toggleOff => 'Toggle Off';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get userName => 'Username';

  @override
  String get password => 'Password';

  @override
  String get appTitle => 'LED control';

  @override
  String get entranceError => 'Login Error. Check login and password';

  @override
  String get voiceTurnOn => 'turn on';

  @override
  String get voiceTurnOff => 'turn off';

  @override
  String get voiceBrightness => 'brightness';

  @override
  String get voiceEffect => 'effect';

  @override
  String get voiceDisableEffect => 'effect off';

  @override
  String get voicePixel => 'pixel';

  @override
  String get voiceRed => 'red';

  @override
  String get voiceGreen => 'green';

  @override
  String get voiceBlue => 'blue';

  @override
  String get voiceYellow => 'yellow';

  @override
  String get voiceWhite => 'white';

  @override
  String get voiceControl => 'Voice control';

  @override
  String get voiceControlOff => 'Off voice control';

  @override
  String get voiceControlEnabled => 'Voice control enable!';

  @override
  String get disableVoiceControl => 'Voice control disable';

  @override
  String get voiceExit => 'Logout';
}
