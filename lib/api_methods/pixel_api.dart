import 'dart:convert';
import 'package:http/http.dart' as http;

class PixelApi {
  static const String baseUrl = 'http://192.168.0.137';

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
      print('Pixel color set successfully');
    } else {
      throw Exception('Failed to set pixel color: ${response.statusCode}');
    }
  }
}
