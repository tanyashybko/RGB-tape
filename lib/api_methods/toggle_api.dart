import 'dart:convert';
import 'package:http/http.dart' as http;

class ToggleApi {
  static const String baseUrl = 'http://192.168.0.137';

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
      print('Power toggled successfully');
    } else {
      throw Exception('Failed to toggle power: ${response.statusCode}');
    }
  }
}
