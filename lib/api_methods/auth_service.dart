import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/foundation.dart';

import 'client_api.dart';

class AuthService {
  final ClientApi apiClient;
  static const String tokenKey = 'auth_token';

  AuthService({required this.apiClient});

  Future<bool> login(String username, String password) async {
    try {
      final response = await apiClient.post('/login', {
        'login': username,
        'password': password,
      });

      final token = response;

      if (token != null && token.isNotEmpty) {
        await _saveToken(token);
        if (kDebugMode) {
          print('Login successful. Token: $token');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Token is empty.');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Login failed. Error: $e');
      }
      return false;
    }
  }

  Future<void> getProtectedResource() async {
    try {
      final token = await getToken();

      if (token == null) {
        throw Exception('No token found. Please login.');
      }

      final data = await apiClient.get('/protected-resource', token: token);
      if (kDebugMode) {
        print('Protected resource data: $data');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching resource: $e');
      }
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(tokenKey);
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(tokenKey);
    if (kDebugMode) {
      print('Logged out successfully.');
    }
  }
}
