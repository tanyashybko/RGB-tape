import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../const.dart';

class LoginApi {
  static const String apiUrl = baseUrl;

  Future<void> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {
          'Content-Type': 'text/plain',
        },
        body: json.encode({
          'login': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print('Logged in successfully');
        }
      } else {
        if (kDebugMode) {
          print('Login failed. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login failed. Error: $e');
      }
    }
  }
}