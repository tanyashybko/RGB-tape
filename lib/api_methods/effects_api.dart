import 'client_api.dart';

class EffectsApi {
  final ClientApi apiClient;

  EffectsApi({required this.apiClient});

  Future<void> changeEffect(int effectId) async {
    await apiClient.post('/effects', {'effect': effectId});
  }
}

