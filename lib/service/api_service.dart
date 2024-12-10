import '../api_methods/imports_api.dart';

class ApiService {
  final BrightnessApi brightnessApi;
  final ColorApi colorApi;
  final EffectsApi effectsApi;
  final PixelApi pixelApi;
  final ToggleApi toggleApi;
  final StatusApi statusApi;
  final LoginApi loginApi;

  ApiService({
    required this.brightnessApi,
    required this.colorApi,
    required this.effectsApi,
    required this.pixelApi,
    required this.toggleApi,
    required this.statusApi,
    required this.loginApi,
  });

  /// Проверка соединения с сервером
  Future<void> testConnection() async {
    await statusApi.checkStatus();
  }

  /// Изменение яркости
  Future<void> changeBrightness(int brightnessLevel) async {
    await brightnessApi.changeBrightness(brightnessLevel);
  }

  /// Изменение цвета
  Future<void> changeColor(int red, int green, int blue) async {
    await colorApi.changeColor(red, green, blue);
  }

  /// Применение эффекта
  Future<void> applyEffect(int effectId) async {
    await effectsApi.changeEffect(effectId);
  }

  /// Изменение цвета пикселя
  Future<void> setPixelColor(int index, int red, int green, int blue) async {
    await pixelApi.changePixelColor(index, red, green, blue);
  }

  /// Переключение питания
  Future<void> togglePower(int state) async {
    await toggleApi.togglePower(state);
  }

  /// Логин
  Future<void> login(String username, String password) async {
    await loginApi.login(username, password);
  }
}
