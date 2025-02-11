import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const.dart';

class BrightnessApi {
  static const String apiUrl = baseUrl;

  Future<void> changeBrightness(int brightnessLevel) async {
    final url = Uri.parse('$baseUrl/brightness');
    final headers = {
      'Content-Type': 'text/plain',
    };
    final body = jsonEncode({
      'brightness': brightnessLevel.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Brightness changed successfully');
      }
    } else {
      throw Exception('Failed to change brightness: ${response.statusCode}');
    }
  }
}
