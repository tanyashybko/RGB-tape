import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rgb_tape/l10n/l10n.dart';
import 'package:rgb_tape/localization/language_switcher.dart';
import 'package:rgb_tape/service/api_service.dart';
import 'package:rgb_tape/api_methods/auth_service.dart';
import '../api_methods/client_api.dart';
import '../api_methods/imports_api.dart';
import '../storage/token_storage.dart' show TokenStorage;

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
  int selectedEffect = 0;
  double brightness = 100;
  final TextEditingController pixelController = TextEditingController();
  bool isPixelValid = true;

  @override
  void initState() {
    super.initState();
    clientApi = ClientApi();
    authService = AuthService(apiClient: clientApi);
    _initializeServices().then((_) {
      if (isLoggedIn) {
        apiService.togglePower(1);
      }
    });
  }

  Future<void> _initializeServices() async {
    final token = await TokenStorage().getToken();
    if (token != null) {
      apiService = ApiService(
        colorApi: ColorApi(apiClient: clientApi),
        brightnessApi: BrightnessApi(apiClient: clientApi),
        effectsApi: EffectsApi(apiClient: clientApi),
        loginApi: AuthService(apiClient: clientApi),
        toggleApi: ToggleApi(apiClient: clientApi),
        pixelApi: PixelApi(apiClient: clientApi),
      );
    } else {
      if (kDebugMode) {
        print(context.l10n.missing);
      }
    }
  }

  void _handleButtonPress(Future<void> Function() apiCall) async {
    setState(() {
      isLoading = true;
    });

    try {
      await apiCall();
      _showMessage(context.l10n.operationSuccessful);
    } catch (e) {
      if (kDebugMode) {
        print('${context.l10n.error}: $e');
      }
      _showMessage(context.l10n.operationFailed, isError: true);
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
        _showMessage(context.l10n.loginSuccessful);
        apiService.togglePower(1);
      } else {
        _showMessage(context.l10n.loginFailed, isError: true);
      }
    });
  }

  Future<void> _handleLogout() async {
    _handleButtonPress(() async {
      await authService.logout();
      setState(() {
        isLoggedIn = false;
      });
      _showMessage(context.l10n.logoutSuccessful);
    });
  }

  void _applyColorChanges() async {
    int red = selectedColor.red;
    int green = selectedColor.green;
    int blue = selectedColor.blue;

    await apiService.changeColor(red, green, blue);
    await apiService.changeBrightness(brightness.toInt());
    await apiService.applyEffect(selectedEffect);
  }

  void _handleColorChange(Color color) {
    setState(() {
      selectedColor = color;
    });


    _applyColorChanges();
  }

  void _handleEffectChange(int? value) {
    if (value != null) {
      setState(() {
        selectedEffect = value;
        _applyColorChanges();
      });
    }
  }

  void _changePixelColor() async {
    int red = selectedColor.red;
    int green = selectedColor.green;
    int blue = selectedColor.blue;

    await apiService.setPixelColor(selectedPixel, red, green, blue);
    _showMessage('${context.l10n.pixel} $selectedPixel ${context.l10n.pixelChange} ($red, $green, $blue)');
  }

  void _validatePixelInput(String value) {
    int? pixel = int.tryParse(value);
    if (pixel != null && pixel >= 1 && pixel <= 22) {
      setState(() {
        selectedPixel = pixel;
        isPixelValid = true;
      });
      _changePixelColor();
      pixelController.clear();
    } else {
      setState(() {
        isPixelValid = false;
      });
      _showMessage(context.l10n.warningPixel, isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: isLoggedIn
          ? AppBar(
        title: Center(child: Text(context.l10n.appTitle)),
        backgroundColor: Colors.purple,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: LanguageSwitcher(),
          ),
        ],
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
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 8,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            child: ColorPicker(
                              pickerColor: selectedColor,
                              onColorChanged: _handleColorChange,
                              showLabel: true,
                              pickerAreaHeightPercent: 0.5,
                              enableAlpha: false,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${context.l10n.selectedColor}: (${selectedColor.red}, ${selectedColor.green}, ${selectedColor.blue})',
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
                          SizedBox(
                            width: 60,
                            child: TextField(
                              controller: pixelController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: context.l10n.pixel,
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: isPixelValid ? Colors.grey : Colors.red,
                                  ),
                                ),
                              ),
                              onSubmitted: _validatePixelInput,
                            ),
                          ),
                          const SizedBox(height: 10),
                          DropdownButton<int>(
                            value: selectedEffect,
                            onChanged: _handleEffectChange,
                            items: List.generate(10, (index) {
                              return DropdownMenuItem(
                                value: index,
                                child: Text(index == 0 ? context.l10n.offEffect : '${context.l10n.effectChange} $index', style: const TextStyle(color: Colors.black)),
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
                                child: Text(context.l10n.toggleOn),
                              ),
                              ElevatedButton(
                                onPressed: () => apiService.togglePower(0),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.red,
                                ),
                                child: Text(context.l10n.toggleOff),
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
                            child: Text(context.l10n.logout),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm() {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                context.l10n.login,
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const SizedBox(height: 20),
              TextField(
                decoration: InputDecoration(
                  labelText: context.l10n.userName,
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: context.l10n.password,
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
                child: Text(context.l10n.login),
              ),
            ],
          ),
        ),
        const Positioned(
          right: 10,
          top: 10,
          child: LanguageSwitcher(),
        ),
      ],
    );
  }
}