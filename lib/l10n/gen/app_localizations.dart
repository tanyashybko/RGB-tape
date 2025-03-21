import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
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
    Locale('ar'),
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
  /// **'Start Listening'**
  String get voiceControl;

  /// No description provided for @voiceControlOff.
  ///
  /// In en, this message translates to:
  /// **'Stop Listening'**
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

  /// No description provided for @numZero.
  ///
  /// In en, this message translates to:
  /// **'zero'**
  String get numZero;

  /// No description provided for @numOne.
  ///
  /// In en, this message translates to:
  /// **'one'**
  String get numOne;

  /// No description provided for @numTwo.
  ///
  /// In en, this message translates to:
  /// **'two'**
  String get numTwo;

  /// No description provided for @numThree.
  ///
  /// In en, this message translates to:
  /// **'three'**
  String get numThree;

  /// No description provided for @numFour.
  ///
  /// In en, this message translates to:
  /// **'four'**
  String get numFour;

  /// No description provided for @numFive.
  ///
  /// In en, this message translates to:
  /// **'five'**
  String get numFive;

  /// No description provided for @numSix.
  ///
  /// In en, this message translates to:
  /// **'six'**
  String get numSix;

  /// No description provided for @numSeven.
  ///
  /// In en, this message translates to:
  /// **'seven'**
  String get numSeven;

  /// No description provided for @numEight.
  ///
  /// In en, this message translates to:
  /// **'eight'**
  String get numEight;

  /// No description provided for @numNine.
  ///
  /// In en, this message translates to:
  /// **'nine'**
  String get numNine;

  /// No description provided for @numTen.
  ///
  /// In en, this message translates to:
  /// **'ten'**
  String get numTen;

  /// No description provided for @numEleven.
  ///
  /// In en, this message translates to:
  /// **'eleven'**
  String get numEleven;

  /// No description provided for @numTwelve.
  ///
  /// In en, this message translates to:
  /// **'twelve'**
  String get numTwelve;

  /// No description provided for @numThirteen.
  ///
  /// In en, this message translates to:
  /// **'thirteen'**
  String get numThirteen;

  /// No description provided for @numFourteen.
  ///
  /// In en, this message translates to:
  /// **'fourteen'**
  String get numFourteen;

  /// No description provided for @numFifteen.
  ///
  /// In en, this message translates to:
  /// **'fifteen'**
  String get numFifteen;

  /// No description provided for @numSixteen.
  ///
  /// In en, this message translates to:
  /// **'sixteen'**
  String get numSixteen;

  /// No description provided for @numSeventeen.
  ///
  /// In en, this message translates to:
  /// **'seventeen'**
  String get numSeventeen;

  /// No description provided for @numEighteen.
  ///
  /// In en, this message translates to:
  /// **'eighteen'**
  String get numEighteen;

  /// No description provided for @numNineteen.
  ///
  /// In en, this message translates to:
  /// **'nineteen'**
  String get numNineteen;

  /// No description provided for @numTwenty.
  ///
  /// In en, this message translates to:
  /// **'twenty'**
  String get numTwenty;

  /// No description provided for @numTwentyOne.
  ///
  /// In en, this message translates to:
  /// **'twenty one'**
  String get numTwentyOne;

  /// No description provided for @numTwentyTwo.
  ///
  /// In en, this message translates to:
  /// **'twenty two'**
  String get numTwentyTwo;

  /// No description provided for @numTwentyThree.
  ///
  /// In en, this message translates to:
  /// **'twenty three'**
  String get numTwentyThree;

  /// No description provided for @numTwentyFour.
  ///
  /// In en, this message translates to:
  /// **'twenty four'**
  String get numTwentyFour;

  /// No description provided for @numTwentyFive.
  ///
  /// In en, this message translates to:
  /// **'twenty five'**
  String get numTwentyFive;

  /// No description provided for @numTwentySix.
  ///
  /// In en, this message translates to:
  /// **'twenty six'**
  String get numTwentySix;

  /// No description provided for @numTwentySeven.
  ///
  /// In en, this message translates to:
  /// **'twenty seven'**
  String get numTwentySeven;

  /// No description provided for @numTwentyEight.
  ///
  /// In en, this message translates to:
  /// **'twenty eight'**
  String get numTwentyEight;

  /// No description provided for @numTwentyNine.
  ///
  /// In en, this message translates to:
  /// **'twenty nine'**
  String get numTwentyNine;

  /// No description provided for @numThirty.
  ///
  /// In en, this message translates to:
  /// **'thirty'**
  String get numThirty;

  /// No description provided for @numThirtyOne.
  ///
  /// In en, this message translates to:
  /// **'thirty one'**
  String get numThirtyOne;

  /// No description provided for @numThirtyTwo.
  ///
  /// In en, this message translates to:
  /// **'thirty two'**
  String get numThirtyTwo;

  /// No description provided for @numThirtyThree.
  ///
  /// In en, this message translates to:
  /// **'thirty three'**
  String get numThirtyThree;

  /// No description provided for @numThirtyFour.
  ///
  /// In en, this message translates to:
  /// **'thirty four'**
  String get numThirtyFour;

  /// No description provided for @numThirtyFive.
  ///
  /// In en, this message translates to:
  /// **'thirty five'**
  String get numThirtyFive;

  /// No description provided for @numThirtySix.
  ///
  /// In en, this message translates to:
  /// **'thirty six'**
  String get numThirtySix;

  /// No description provided for @numThirtySeven.
  ///
  /// In en, this message translates to:
  /// **'thirty seven'**
  String get numThirtySeven;

  /// No description provided for @numThirtyEight.
  ///
  /// In en, this message translates to:
  /// **'thirty eight'**
  String get numThirtyEight;

  /// No description provided for @numThirtyNine.
  ///
  /// In en, this message translates to:
  /// **'thirty nine'**
  String get numThirtyNine;

  /// No description provided for @numForty.
  ///
  /// In en, this message translates to:
  /// **'forty'**
  String get numForty;

  /// No description provided for @numFortyOne.
  ///
  /// In en, this message translates to:
  /// **'forty one'**
  String get numFortyOne;

  /// No description provided for @numFortyTwo.
  ///
  /// In en, this message translates to:
  /// **'forty two'**
  String get numFortyTwo;

  /// No description provided for @numFortyThree.
  ///
  /// In en, this message translates to:
  /// **'forty three'**
  String get numFortyThree;

  /// No description provided for @numFortyFour.
  ///
  /// In en, this message translates to:
  /// **'forty four'**
  String get numFortyFour;

  /// No description provided for @numFortyFive.
  ///
  /// In en, this message translates to:
  /// **'forty five'**
  String get numFortyFive;

  /// No description provided for @numFortySix.
  ///
  /// In en, this message translates to:
  /// **'forty six'**
  String get numFortySix;

  /// No description provided for @numFortySeven.
  ///
  /// In en, this message translates to:
  /// **'forty seven'**
  String get numFortySeven;

  /// No description provided for @numFortyEight.
  ///
  /// In en, this message translates to:
  /// **'forty eight'**
  String get numFortyEight;

  /// No description provided for @numFortyNine.
  ///
  /// In en, this message translates to:
  /// **'forty nine'**
  String get numFortyNine;

  /// No description provided for @numFifty.
  ///
  /// In en, this message translates to:
  /// **'fifty'**
  String get numFifty;

  /// No description provided for @numFiftyOne.
  ///
  /// In en, this message translates to:
  /// **'fifty one'**
  String get numFiftyOne;

  /// No description provided for @numFiftyTwo.
  ///
  /// In en, this message translates to:
  /// **'fifty two'**
  String get numFiftyTwo;

  /// No description provided for @numFiftyThree.
  ///
  /// In en, this message translates to:
  /// **'fifty three'**
  String get numFiftyThree;

  /// No description provided for @numFiftyFour.
  ///
  /// In en, this message translates to:
  /// **'fifty four'**
  String get numFiftyFour;

  /// No description provided for @numFiftyFive.
  ///
  /// In en, this message translates to:
  /// **'fifty five'**
  String get numFiftyFive;

  /// No description provided for @numFiftySix.
  ///
  /// In en, this message translates to:
  /// **'fifty six'**
  String get numFiftySix;

  /// No description provided for @numFiftySeven.
  ///
  /// In en, this message translates to:
  /// **'fifty seven'**
  String get numFiftySeven;

  /// No description provided for @numFiftyEight.
  ///
  /// In en, this message translates to:
  /// **'fifty eight'**
  String get numFiftyEight;

  /// No description provided for @numFiftyNine.
  ///
  /// In en, this message translates to:
  /// **'fifty nine'**
  String get numFiftyNine;

  /// No description provided for @numSixty.
  ///
  /// In en, this message translates to:
  /// **'sixty'**
  String get numSixty;

  /// No description provided for @numSixtyOne.
  ///
  /// In en, this message translates to:
  /// **'sixty one'**
  String get numSixtyOne;

  /// No description provided for @numSixtyTwo.
  ///
  /// In en, this message translates to:
  /// **'sixty two'**
  String get numSixtyTwo;

  /// No description provided for @numSixtyThree.
  ///
  /// In en, this message translates to:
  /// **'sixty three'**
  String get numSixtyThree;

  /// No description provided for @numSixtyFour.
  ///
  /// In en, this message translates to:
  /// **'sixty four'**
  String get numSixtyFour;

  /// No description provided for @numSixtyFive.
  ///
  /// In en, this message translates to:
  /// **'sixty five'**
  String get numSixtyFive;

  /// No description provided for @numSixtySix.
  ///
  /// In en, this message translates to:
  /// **'sixty six'**
  String get numSixtySix;

  /// No description provided for @numSixtySeven.
  ///
  /// In en, this message translates to:
  /// **'sixty seven'**
  String get numSixtySeven;

  /// No description provided for @numSixtyEight.
  ///
  /// In en, this message translates to:
  /// **'sixty eight'**
  String get numSixtyEight;

  /// No description provided for @numSixtyNine.
  ///
  /// In en, this message translates to:
  /// **'sixty nine'**
  String get numSixtyNine;

  /// No description provided for @numSeventy.
  ///
  /// In en, this message translates to:
  /// **'seventy'**
  String get numSeventy;

  /// No description provided for @numSeventyOne.
  ///
  /// In en, this message translates to:
  /// **'seventy one'**
  String get numSeventyOne;

  /// No description provided for @numSeventyTwo.
  ///
  /// In en, this message translates to:
  /// **'seventy two'**
  String get numSeventyTwo;

  /// No description provided for @numSeventyThree.
  ///
  /// In en, this message translates to:
  /// **'seventy three'**
  String get numSeventyThree;

  /// No description provided for @numSeventyFour.
  ///
  /// In en, this message translates to:
  /// **'seventy four'**
  String get numSeventyFour;

  /// No description provided for @numSeventyFive.
  ///
  /// In en, this message translates to:
  /// **'seventy five'**
  String get numSeventyFive;

  /// No description provided for @numSeventySix.
  ///
  /// In en, this message translates to:
  /// **'seventy six'**
  String get numSeventySix;

  /// No description provided for @numSeventySeven.
  ///
  /// In en, this message translates to:
  /// **'seventy seven'**
  String get numSeventySeven;

  /// No description provided for @numSeventyEight.
  ///
  /// In en, this message translates to:
  /// **'seventy eight'**
  String get numSeventyEight;

  /// No description provided for @numSeventyNine.
  ///
  /// In en, this message translates to:
  /// **'seventy nine'**
  String get numSeventyNine;

  /// No description provided for @numEighty.
  ///
  /// In en, this message translates to:
  /// **'eighty'**
  String get numEighty;

  /// No description provided for @numEightyOne.
  ///
  /// In en, this message translates to:
  /// **'eighty one'**
  String get numEightyOne;

  /// No description provided for @numEightyTwo.
  ///
  /// In en, this message translates to:
  /// **'eighty two'**
  String get numEightyTwo;

  /// No description provided for @numEightyThree.
  ///
  /// In en, this message translates to:
  /// **'eighty three'**
  String get numEightyThree;

  /// No description provided for @numEightyFour.
  ///
  /// In en, this message translates to:
  /// **'eighty four'**
  String get numEightyFour;

  /// No description provided for @numEightyFive.
  ///
  /// In en, this message translates to:
  /// **'eighty five'**
  String get numEightyFive;

  /// No description provided for @numEightySix.
  ///
  /// In en, this message translates to:
  /// **'eighty six'**
  String get numEightySix;

  /// No description provided for @numEightySeven.
  ///
  /// In en, this message translates to:
  /// **'eighty seven'**
  String get numEightySeven;

  /// No description provided for @numEightyEight.
  ///
  /// In en, this message translates to:
  /// **'eighty eight'**
  String get numEightyEight;

  /// No description provided for @numEightyNine.
  ///
  /// In en, this message translates to:
  /// **'eighty nine'**
  String get numEightyNine;

  /// No description provided for @numNinety.
  ///
  /// In en, this message translates to:
  /// **'ninety'**
  String get numNinety;

  /// No description provided for @numNinetyOne.
  ///
  /// In en, this message translates to:
  /// **'ninety one'**
  String get numNinetyOne;

  /// No description provided for @numNinetyTwo.
  ///
  /// In en, this message translates to:
  /// **'ninety two'**
  String get numNinetyTwo;

  /// No description provided for @numNinetyThree.
  ///
  /// In en, this message translates to:
  /// **'ninety three'**
  String get numNinetyThree;

  /// No description provided for @numNinetyFour.
  ///
  /// In en, this message translates to:
  /// **'ninety four'**
  String get numNinetyFour;

  /// No description provided for @numNinetyFive.
  ///
  /// In en, this message translates to:
  /// **'ninety five'**
  String get numNinetyFive;

  /// No description provided for @numNinetySix.
  ///
  /// In en, this message translates to:
  /// **'ninety six'**
  String get numNinetySix;

  /// No description provided for @numNinetySeven.
  ///
  /// In en, this message translates to:
  /// **'ninety seven'**
  String get numNinetySeven;

  /// No description provided for @numNinetyEight.
  ///
  /// In en, this message translates to:
  /// **'ninety eight'**
  String get numNinetyEight;

  /// No description provided for @numNinetyNine.
  ///
  /// In en, this message translates to:
  /// **'ninety nine'**
  String get numNinetyNine;

  /// No description provided for @numOneHundred.
  ///
  /// In en, this message translates to:
  /// **'one hundred'**
  String get numOneHundred;

  /// No description provided for @numFirst.
  ///
  /// In en, this message translates to:
  /// **'first'**
  String get numFirst;

  /// No description provided for @numSecond.
  ///
  /// In en, this message translates to:
  /// **'second'**
  String get numSecond;

  /// No description provided for @numThird.
  ///
  /// In en, this message translates to:
  /// **'third'**
  String get numThird;

  /// No description provided for @numFourth.
  ///
  /// In en, this message translates to:
  /// **'fourth'**
  String get numFourth;

  /// No description provided for @numFifth.
  ///
  /// In en, this message translates to:
  /// **'fifth'**
  String get numFifth;

  /// No description provided for @numSixth.
  ///
  /// In en, this message translates to:
  /// **'sixth'**
  String get numSixth;

  /// No description provided for @numSeventh.
  ///
  /// In en, this message translates to:
  /// **'seventh'**
  String get numSeventh;

  /// No description provided for @numEighth.
  ///
  /// In en, this message translates to:
  /// **'eighth'**
  String get numEighth;

  /// No description provided for @numNinth.
  ///
  /// In en, this message translates to:
  /// **'ninth'**
  String get numNinth;

  /// No description provided for @numTenth.
  ///
  /// In en, this message translates to:
  /// **'tenth'**
  String get numTenth;

  /// No description provided for @numEleventh.
  ///
  /// In en, this message translates to:
  /// **'eleventh'**
  String get numEleventh;

  /// No description provided for @numTwelfth.
  ///
  /// In en, this message translates to:
  /// **'twelfth'**
  String get numTwelfth;

  /// No description provided for @numThirteenth.
  ///
  /// In en, this message translates to:
  /// **'thirteenth'**
  String get numThirteenth;

  /// No description provided for @numFourteenth.
  ///
  /// In en, this message translates to:
  /// **'fourteenth'**
  String get numFourteenth;

  /// No description provided for @numFifteenth.
  ///
  /// In en, this message translates to:
  /// **'fifteenth'**
  String get numFifteenth;

  /// No description provided for @numSixteenth.
  ///
  /// In en, this message translates to:
  /// **'sixteenth'**
  String get numSixteenth;

  /// No description provided for @numSeventeenth.
  ///
  /// In en, this message translates to:
  /// **'seventeenth'**
  String get numSeventeenth;

  /// No description provided for @numEighteenth.
  ///
  /// In en, this message translates to:
  /// **'eighteenth'**
  String get numEighteenth;

  /// No description provided for @numNineteenth.
  ///
  /// In en, this message translates to:
  /// **'nineteenth'**
  String get numNineteenth;

  /// No description provided for @numTwentieth.
  ///
  /// In en, this message translates to:
  /// **'twentieth'**
  String get numTwentieth;

  /// No description provided for @numTwentyFirst.
  ///
  /// In en, this message translates to:
  /// **'twenty-first'**
  String get numTwentyFirst;

  /// No description provided for @numTwentySecond.
  ///
  /// In en, this message translates to:
  /// **'twenty-second'**
  String get numTwentySecond;

  /// No description provided for @pixelRed.
  ///
  /// In en, this message translates to:
  /// **'red'**
  String get pixelRed;

  /// No description provided for @pixelBlue.
  ///
  /// In en, this message translates to:
  /// **'blue'**
  String get pixelBlue;

  /// No description provided for @pixelGreen.
  ///
  /// In en, this message translates to:
  /// **'green'**
  String get pixelGreen;

  /// No description provided for @pixelYellow.
  ///
  /// In en, this message translates to:
  /// **'yellow'**
  String get pixelYellow;

  /// No description provided for @pixelWhite.
  ///
  /// In en, this message translates to:
  /// **'white'**
  String get pixelWhite;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
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
