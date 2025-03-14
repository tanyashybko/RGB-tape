import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rgb_tape/api_methods/auth_service.dart';
import 'package:rgb_tape/api_methods/brightness_api.dart';
import 'package:rgb_tape/api_methods/color_api.dart';
import 'package:rgb_tape/api_methods/effects_api.dart';
import 'package:rgb_tape/api_methods/pixel_api.dart';
import 'package:rgb_tape/api_methods/toggle_api.dart';
import 'package:rgb_tape/l10n/l10n.dart';
import 'package:rgb_tape/localization/language_switcher.dart';
import 'package:rgb_tape/service/api_service.dart';
import 'package:rgb_tape/voice/voice_api.dart';
import 'package:rgb_tape/voice/voice_command_handler.dart';

import '../api_methods/client_api.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({super.key});

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  late final ApiService apiService;
  late final VoiceApi voiceApi;
  late final VoiceCommandHandler voiceCommandHandler;
  bool isVoiceControlEnabled = false;
  bool isLoading = false;
  Color selectedColor = Colors.white;
  double brightness = 100;
  int selectedEffect = 0;
  final TextEditingController _pixelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final client = ClientApi();

    apiService = ApiService(
      colorApi: ColorApi(apiClient: client),
      brightnessApi: BrightnessApi(apiClient: client),
      effectsApi: EffectsApi(apiClient: client),
      pixelApi: PixelApi(apiClient: client),
      toggleApi: ToggleApi(apiClient: client),
      loginApi: AuthService(apiClient: client),
    );

    voiceApi = VoiceApi();
    voiceCommandHandler = VoiceCommandHandler(
      apiService: apiService,
      voiceApi: voiceApi,
      onEnable: _enableVoiceControl,
      onDisable: _disableVoiceControl,
      onColorChange: _handleColorChange,
      onBrightnessChange: _handleBrightnessChange,
      onEffectChange: _handleEffectChange,
      onLogout: _logout,
    );

    voiceApi.init();
  }

  void _enableVoiceControl() {
    setState(() {
      isVoiceControlEnabled = true;
    });

    voiceApi.startListening((command) {
      voiceCommandHandler.handleVoiceCommand(command.toLowerCase(), context);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.voiceControlEnabled)),
    );
  }

  void _disableVoiceControl() {
    setState(() {
      isVoiceControlEnabled = false;
    });

    voiceApi.stopListening();
  }

  void _logout() {
    apiService.loginApi.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _handleColorChange(Color color) {
    setState(() {
      selectedColor = color;
    });
    apiService.changeColor(color.red, color.green, color.blue);
  }

  void _handleBrightnessChange(double value) {
    setState(() {
      brightness = value;
    });
    apiService.changeBrightness(brightness.toInt());
  }

  void _handleEffectChange(int effect) {
    setState(() {
      selectedEffect = effect;
    });
    apiService.applyEffect(selectedEffect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.mainPage,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        backgroundColor: Colors.purple[300],
        actions: const [
          LanguageSwitcher(),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
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
                      _handleBrightnessChange(value);
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: selectedEffect,
                    onChanged: (value) {
                      if (value != null) {
                        _handleEffectChange(value);
                      }
                    },
                    items: List.generate(10, (index) {
                      return DropdownMenuItem(
                        value: index,
                        child: Text(index == 0 ? context.l10n.offEffect : '${context.l10n.effectChange} $index'),
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
                  Center(
                    child: SizedBox(
                      width: 50,
                      child: TextFormField(
                        controller: _pixelController,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                        ),
                        onFieldSubmitted: (value) async {
                          final pixelNumber = int.tryParse(value);
                          if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
                            await apiService.pixelApi.changePixelColor(
                              pixelNumber,
                              selectedColor.red,
                              selectedColor.green,
                              selectedColor.blue,
                            );
                            _pixelController.clear();
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(context.l10n.warningPixel)),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: isVoiceControlEnabled ? _disableVoiceControl : _enableVoiceControl,
                    child: Text(isVoiceControlEnabled ? context.l10n.disableVoiceControl : context.l10n.voiceControlEnabled),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _logout,
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
      ),
    );
  }
}

