import 'dart:convert';
import 'package:http/http.dart' as http;

class EffectsApi {
  static const String baseUrl = 'http://192.168.0.137';

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
      print('Effect applied successfully');
    } else {
      throw Exception('Failed to apply effect: ${response.statusCode}');
    }
  }
}
