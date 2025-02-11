import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const.dart';

class EffectsApi {
  static const String apiUrl = baseUrl;

  Future<void> changeEffect(int effectId) async {
    final url = Uri.parse('$baseUrl/effects');
    final headers = {
      'Content-Type': 'text/plain',
    };
    final body = jsonEncode({
      'effect': effectId.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Effect applied successfully');
      }
    } else {
      throw Exception('Failed to apply effect: ${response.statusCode}');
    }
  }
}
