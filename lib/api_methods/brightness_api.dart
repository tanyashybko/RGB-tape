import 'dart:convert';
import 'package:http/http.dart' as http;

class BrightnessApi {
  static const String baseUrl = 'http://192.168.0.137';

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
      print('Brightness changed successfully');
    } else {
      throw Exception('Failed to change brightness: ${response.statusCode}');
    }
  }
}
