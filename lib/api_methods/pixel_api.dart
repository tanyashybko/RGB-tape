import 'client_api.dart';

class PixelApi {
  final ClientApi apiClient;

  PixelApi({required this.apiClient});

  Future<void> changePixelColor(int index, int red, int green, int blue) async {
    await apiClient.post('/pixel', {
      'index': index,
      'red': red,
      'green': green,
      'blue': blue,
    });
  }
}
