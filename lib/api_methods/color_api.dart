import 'dart:convert';
import 'package:http/http.dart' as http;

class ColorApi {
  static const String baseUrl = 'http://192.168.0.137';

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
      print('Color changed successfully');
    } else {
      throw Exception('Failed to change color: ${response.statusCode}');
    }
  }
}

/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rgb_tape/api_methods/AuthService.dart'; // Обратите внимание на правильный путь к AuthService

class ColorApi {
  static const String baseUrl = 'http://192.168.0.137';
  final AuthService _authService;

  // Конструктор для инъекции зависимости
  ColorApi(this._authService);

  Future<void> changeColor(int red, int green, int blue) async {
    // Получение токена из AuthService
    final token = await _authService.getToken();

    // Проверка, если токен не найден
    if (token == null) {
      throw Exception('Authentication token not found. Please login.');
    }

    // Установка URL для запроса
    final url = Uri.parse('$baseUrl/color');

    // Заголовки с токеном
    final headers = {
      'Content-Type': 'text/plain',
      //'Authorization': 'Bearer $token',  // Передача токена в заголовке
    };

    // Тело запроса
    final body = jsonEncode({
      'red': red.toString(),
      'green': green.toString(),
      'blue': blue.toString(),
    });

    // Отправка POST-запроса
    final response = await http.post(url, headers: headers, body: body);

    // Обработка ответа
    if (response.statusCode == 200) {
      print('Color changed successfully');
    } else {
      throw Exception('Failed to change color: ${response.statusCode}');
    }
  }
}*/
