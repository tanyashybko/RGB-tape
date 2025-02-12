import 'client_api.dart';

class LoginApi {
  final ClientApi apiClient;

  LoginApi({required this.apiClient});

  Future<void> login(String username, String password) async {
    await apiClient.post('/login', {
      'login': username,
      'password': password,
    });
  }
}
