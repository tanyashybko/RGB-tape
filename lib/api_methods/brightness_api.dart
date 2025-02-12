import 'client_api.dart';

class BrightnessApi {
  final ClientApi apiClient;

  BrightnessApi({required this.apiClient});

  Future<void> changeBrightness(int brightnessLevel) async {
    await apiClient.post('/brightness', {'brightness': brightnessLevel});
  }
}
