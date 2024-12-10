import 'package:http/http.dart' as http;

class StatusApi {
  static const String baseUrl = 'http://192.168.0.137';

  Future<void> checkStatus() async {
    final url = Uri.parse('$baseUrl/status');
    final headers = {
      'Content-Type': 'text/plain',
    };

    final response = await http.post(url, headers: headers);

    if (response.statusCode == 200) {
      print('Server is up');
    } else {
      throw Exception('Failed to connect: ${response.statusCode}');
    }
  }
}
