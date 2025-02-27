import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
  Color selectedColor = Colors.white;
  int selectedPixel = 0;
  int selectedEffect = 1;
  double brightness = 100;
  bool isSinglePixelMode = false;

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

  void _applyColorChanges() async {
    if (isSinglePixelMode) {
      await apiService.setPixelColor(selectedPixel, selectedColor.red, selectedColor.green, selectedColor.blue);
    } else {
      await apiService.changeColor(selectedColor.red, selectedColor.green, selectedColor.blue);
    }
    await apiService.changeBrightness(brightness.toInt());
    await apiService.applyEffect(selectedEffect);
  }

  void _handleColorChange(Color color) {
    setState(() {
      selectedColor = color;
      _applyColorChanges();
    });
  }

  void _handleEffectChange(int? value) {
    if (value != null) {
      setState(() {
        selectedEffect = value;
        _applyColorChanges();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: isLoggedIn
          ? AppBar(
        title: const Center(child: Text('Menu')),
        backgroundColor: Colors.purple,
      )
          : null,
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (!isLoggedIn) ...[
                _buildLoginForm(),
              ] else ...[
                Container(
                  width: 240,
                  height: 240,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.transparent,
                  ),
                  child: ColorPicker(
                    pickerColor: selectedColor,
                    onColorChanged: _handleColorChange,
                    showLabel: false,
                    pickerAreaHeightPercent: 0.8,
                    enableAlpha: false,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Color: (${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue})',
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Slider(
                  value: brightness,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: brightness.round().toString(),
                  onChanged: (value) {
                    setState(() {
                      brightness = value;
                      _applyColorChanges();
                    });
                  },
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: TextField(
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Pixel',
                          filled: true,
                          fillColor: Colors.white,
                        ),
                        onChanged: (value) {
                          setState(() {
                            selectedPixel = int.tryParse(value) ?? 0;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('Single Pixel Mode'),
                    Switch(
                      value: isSinglePixelMode,
                      onChanged: (value) {
                        setState(() {
                          isSinglePixelMode = value;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                DropdownButton<int>(
                  value: selectedEffect,
                  onChanged: _handleEffectChange,
                  items: List.generate(10, (index) {
                    return DropdownMenuItem(
                      value: index,
                      child: Text(index == 0 ? 'Off' : 'Effect $index', style: const TextStyle(color: Colors.black)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () => apiService.togglePower(1),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.green,
                      ),
                      child: const Text('Toggle On'),
                    ),
                    ElevatedButton(
                      onPressed: () => apiService.togglePower(0),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.red,
                      ),
                      child: const Text('Toggle Off'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _handleLogout,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: const Text('Logout'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
          ),
          const SizedBox(height: 20),
          const TextField(
            decoration: InputDecoration(
              labelText: 'Username',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          const TextField(
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              filled: true,
              fillColor: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _handleLogin,
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.blue,
            ),
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}