import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../const.dart';

class ColorApi {
  static const String apiUrl = baseUrl;

  Future<void> changeColor(int red, int green, int blue) async {
    final url = Uri.parse('$baseUrl/color');
    final headers = {
      'Content-Type': 'text/plain',
    };
    final body = jsonEncode({
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
    });

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print('Color changed successfully');
      }
    } else {
      throw Exception('Failed to change color: ${response.statusCode}');
    }
  }
}