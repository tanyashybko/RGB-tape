import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const.dart';

class ToggleApi {
  static const String apiUrl = baseUrl;

  Future<void> togglePower(int state) async {
    final url = Uri.parse('$baseUrl/toggle');
    final headers = {
      'Content-Type': 'text/plain',
    };
    final body = jsonEncode({
      'state': state.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Power toggled successfully');
      }
    } else {
      throw Exception('Failed to toggle power: ${response.statusCode}');
    }
  }
}
