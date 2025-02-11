import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const.dart';

class PixelApi {
  static const String apiUrl = baseUrl;

  Future<void> changePixelColor(int index, int red, int green, int blue) async {
    final url = Uri.parse('$baseUrl/pixel');
    final headers = {
      'Content-Type': 'text/plain',
    };
    final body = jsonEncode({
      'index': index.toString(),
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Pixel color set successfully');
      }
    } else {
      throw Exception('Failed to set pixel color: ${response.statusCode}');
    }
  }
}
