import 'client_api.dart';

class ColorApi {
  final ClientApi apiClient;

  ColorApi({required this.apiClient});

  Future<void> changeColor(int red, int green, int blue) async {
    await apiClient.post('/color', {
      'red': red,
      'green': green,
      'blue': blue,
    });
  }
}
