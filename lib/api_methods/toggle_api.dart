import 'package:flutter/foundation.dart';
import 'client_api.dart';

class ToggleApi {
  final ClientApi apiClient;

  ToggleApi({required this.apiClient});

  Future<void> togglePower(int state) async {
    try {
      await apiClient.postRaw('/toggle', state.toString());
      if (kDebugMode) {
        print('Power toggled successfully');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Failed to toggle power: $e');
      }
      throw Exception('Failed to toggle power');
    }
  }
}
