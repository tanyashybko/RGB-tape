import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static const String tokenKey = 'auth_token';
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  Future<void> saveToken(String token) async {
    await _storage.write(key: tokenKey, value: token);
  }

  Future<String?> getToken() async {
    return await _storage.read(key: tokenKey);
  }

  Future<void> removeToken() async {
    await _storage.delete(key: tokenKey);
  }
}
