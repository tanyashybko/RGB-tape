// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get missing => 'Отсутсвует токен. Пожалуйста, авторизируйтесь.';

  @override
  String get operationSuccessful => 'Операция завершена успешно!';

  @override
  String get error => 'Ошибка';

  @override
  String get operationFailed => 'Не удалось завершить операцию.';

  @override
  String get loginSuccessful => 'Вы успешно вошли в систему!';

  @override
  String get loginFailed => 'Не удалось войти.';

  @override
  String get logoutSuccessful => 'Вы успешно вышли из системы.';

  @override
  String get pixel => 'Пиксель';

  @override
  String get pixelChange => 'цвет изменён на';

  @override
  String get warningPixel => 'Пожалуйста, введите число от 1 до 22.';

  @override
  String get applyPixel => 'Применить цвет пикселя';

  @override
  String get mainPage => 'Страница управления';

  @override
  String get selectedColor => 'Выбранный цвет';

  @override
  String get offEffect => 'Выкл';

  @override
  String get effectChange => 'Эффект';

  @override
  String get toggleOn => 'Включить';

  @override
  String get toggleOff => 'Выключить';

  @override
  String get logout => 'Выход';

  @override
  String get login => 'Вход';

  @override
  String get userName => 'Имя пользователя';

  @override
  String get password => 'Пароль';

  @override
  String get appTitle => 'Управление светодиодной лентой';

  @override
  String get entranceError => 'Ошибка входа. Проверьте логин и пароль';

  @override
  String get voiceTurnOn => 'включи';

  @override
  String get voiceTurnOff => 'выключи';

  @override
  String get voiceBrightness => 'яркость';

  @override
  String get voiceEffect => 'эффект';

  @override
  String get voiceDisableEffect => 'эффект выключи';

  @override
  String get voicePixel => 'пиксель';

  @override
  String get voiceRed => 'красный';

  @override
  String get voiceGreen => 'зелёный';

  @override
  String get voiceBlue => 'синий';

  @override
  String get voiceYellow => 'жёлтый';

  @override
  String get voiceWhite => 'белый';

  @override
  String get voiceControl => 'Начать слушать';

  @override
  String get voiceControlOff => 'Закончить слушать';

  @override
  String get voiceControlEnabled => 'Включено голосовое управление!';

  @override
  String get disableVoiceControl => 'Голосовое управление выключено';

  @override
  String get voiceExit => 'Выход';

  @override
  String get numZero => 'ноль';

  @override
  String get numOne => 'один';

  @override
  String get numTwo => 'два';

  @override
  String get numThree => 'три';

  @override
  String get numFour => 'четыре';

  @override
  String get numFive => 'пять';

  @override
  String get numSix => 'шесть';

  @override
  String get numSeven => 'семь';

  @override
  String get numEight => 'восьмой';

  @override
  String get numNine => 'девять';
}
