import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://192.168.0.137';
  static const String tokenKey = 'auth_token';

  Future<bool> login(String username, String password) async {
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

      if (kDebugMode) {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
      }

      if (response.statusCode == 200) {
        final token = response.body; // Directly use the response body as the token
        if (token.isNotEmpty) {
          await _saveToken(token); // Save the token
          if (kDebugMode) {
            print('Login successful. Token: $token');
          }
          return true;
        } else {
          if (kDebugMode) {
            print('Token is empty.');
          }
        }
      } else {
        if (kDebugMode) {
          print('Login failed. Status code: ${response.statusCode}');
        }
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Login failed. Error: $e');
      }
      return false;
    }
  }

  // Method to fetch a protected resource
  Future<void> getProtectedResource() async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found. Please login.');
      }

      final response = await http.get(
        Uri.parse('$baseUrl/protected-resource'),
        headers: {
          'Content-Type': 'text/plain',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (kDebugMode) {
          print('Protected resource data: $data');
        }
      } else {
        if (kDebugMode) {
          print('Failed to fetch resource. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching resource: $e');
      }
    }
  }

  // Save the token in SharedPreferences
  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  // Public method to get the token
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  // Logout and remove the token
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    if (kDebugMode) {
      print('Logged out successfully.');
    }
  }
}

