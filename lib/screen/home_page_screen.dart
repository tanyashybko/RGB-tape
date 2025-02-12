import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rgb_tape/service/api_service.dart';
import 'package:rgb_tape/api_methods/auth_service.dart';
import '../api_methods/client_api.dart';
import '../api_methods/imports_api.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late final ApiService apiService;
  late final ClientApi clientApi;
  late final AuthService authService;

  bool isLoading = false;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    clientApi = ClientApi();
    authService = AuthService(apiClient: clientApi);
    _initializeServices();
  }

  Future<void> _initializeServices() async {
    final token = await authService.getToken();

    if (token != null) {
      apiService = ApiService(
        colorApi: ColorApi(apiClient: clientApi),
        brightnessApi: BrightnessApi(apiClient: clientApi),
        effectsApi: EffectsApi(apiClient: clientApi),
        loginApi: LoginApi(apiClient: clientApi),
        toggleApi: ToggleApi(apiClient: clientApi),
        pixelApi: PixelApi(apiClient: clientApi),
      );
    } else {
      if (kDebugMode) {
        print('Token is missing. Authorize.');
      }
    }
  }
  // Future<void> _checkAuthStatus() async {
  //   final token = await authService.getToken();
  //   if (token != null) {
  //     try {
  //       await apiService.testConnection();
  //       setState(() {
  //         isLoggedIn = true;
  //       });
  //     } catch (e) {
  //       setState(() {
  //         isLoggedIn = false;
  //       });
  //       await authService.logout();
  //       _showMessage('Session expired, please log in again.', isError: true);
  //     }
  //   } else {
  //     setState(() {
  //       isLoggedIn = false;
  //     });
  //   }
  // }

  void _handleButtonPress(Future<void> Function() apiCall) async {
    setState(() {
      isLoading = true;
    });

    try {
      await apiCall();
      _showMessage('Operation successful!');
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      _showMessage('Failed to complete operation.', isError: true);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _handleLogin() async {
    _handleButtonPress(() async {
      final result = await authService.login('admin', '010404');
      if (result) {
        setState(() {
          isLoggedIn = true;
        });
        _showMessage('Login successful!');
      } else {
        _showMessage('Login failed.', isError: true);
      }
    });
  }

  Future<void> _handleLogout() async {
    _handleButtonPress(() async {
      await authService.logout();
      setState(() {
        isLoggedIn = false;
      });
      _showMessage('Logged out successfully.');
    });
  }

  Widget _buildButton(String label, Future<void> Function() onPressed) {
    return ElevatedButton(
      onPressed: () => _handleButtonPress(onPressed),
      child: Text(label),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RGB LED Control'),
      ),
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isLoggedIn)
              _buildButton('Login', _handleLogin),
            if (isLoggedIn) ...[
              _buildButton('Change Color to Red',
                      () => apiService.changeColor(255, 0, 0)),
              _buildButton('Change Brightness to 50%',
                      () => apiService.changeBrightness(50)),
              _buildButton('Apply the ninth Effect',
                      () => apiService.applyEffect(9)),
              _buildButton('Set Pixel Color to Green',
                      () => apiService.setPixelColor(0, 0, 255, 0)),
              _buildButton('Toggle Power', () => apiService.togglePower(1)),
              _buildButton('Logout', _handleLogout),
            ],
          ],
        ),
      ),
    );
  }
}
