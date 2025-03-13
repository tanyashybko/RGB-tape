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

import '../api_methods/client_api.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({super.key});

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  late final ApiService apiService;
  late final VoiceApi voiceApi;
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
    voiceApi.init();
  }

  void _enableVoiceControl() {
    setState(() {
      isVoiceControlEnabled = true;
    });

    voiceApi.startListening((command) {
      _handleVoiceCommand(command.toLowerCase());
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

  Future<void> _handleVoiceCommand(String command) async {
    if (command.contains(context.l10n.voiceTurnOn)) {
      apiService.togglePower(1);
    } else if (command.contains(context.l10n.voiceTurnOff)) {
      apiService.togglePower(0);
    } else if (command.contains(context.l10n.voiceBrightness)) {
      final brightnessMatch = RegExp(r'\d+').firstMatch(command);
      if (brightnessMatch != null) {
        final brightnessValue = double.tryParse(brightnessMatch.group(0)!);
        if (brightnessValue != null) {
          setState(() {
            brightness = brightnessValue;
            _applyColorChanges();
          });
        }
      }
    } else if (command.contains(context.l10n.voiceEffect)) {
      final effectMatch = RegExp(r'\d+').firstMatch(command);
      if (effectMatch != null) {
        final effectValue = int.tryParse(effectMatch.group(0)!);
        if (effectValue != null) {
          setState(() {
            selectedEffect = effectValue;
            _applyColorChanges();
          });
        }
      }
    } else if (command.contains(context.l10n.voiceDisableEffect)) {
      setState(() {
        selectedEffect = 0;
      });
      apiService.applyEffect(0);
    } else if (command.contains(context.l10n.voiceRed)) {
      setState(() {
        selectedColor = Colors.red;
      });
      _applyColorChanges();
    } else if (command.contains(context.l10n.voiceGreen)) {
      setState(() {
        selectedColor = Colors.green;
      });
      _applyColorChanges();
    } else if (command.contains(context.l10n.voiceBlue)) {
      setState(() {
        selectedColor = Colors.blue;
      });
      _applyColorChanges();
    } else if (command.contains(context.l10n.voiceYellow)) {
      setState(() {
        selectedColor = Colors.yellow;
      });
      _applyColorChanges();
    } else if (command.contains(context.l10n.voiceWhite)) {
      setState(() {
        selectedColor = Colors.white;
      });
      _applyColorChanges();
    } else if (command.contains(context.l10n.voicePixel)) {
      final pixelMatch = RegExp(r'пиксель (\d+)').firstMatch(command);
      final colorMatch = RegExp(r'красный|зелёный|синий|жёлтый|белый').firstMatch(command);

      if (pixelMatch != null && colorMatch != null) {
        final pixelNumber = int.tryParse(pixelMatch.group(1)!);
        Color pixelColor = Colors.white;

        switch (colorMatch.group(0)) {
          case 'красный':
            pixelColor = Colors.red;
            break;
          case 'зелёный':
            pixelColor = Colors.green;
            break;
          case 'синий':
            pixelColor = Colors.blue;
            break;
          case 'жёлтый':
            pixelColor = Colors.yellow;
            break;
          case 'белый':
            pixelColor = Colors.white;
            break;
        }

        if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
          await apiService.pixelApi.changePixelColor(pixelNumber, pixelColor.red, pixelColor.green, pixelColor.blue);
        }
      }
    } else if (command.contains(context.l10n.voiceExit)) {
      _logout(); // Logout command
    }
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

        if (selectedEffect == 0) {
          apiService.applyEffect(0);
        } else {
          _applyColorChanges();
        }
      });
    }
  }

  void _logout() {
    apiService.loginApi.logout();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _applyPixelColor() async {
    final pixelNumber = int.tryParse(_pixelController.text);
    if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
      await apiService.pixelApi.changePixelColor(pixelNumber, selectedColor.red, selectedColor.green, selectedColor.blue);

      _pixelController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.l10n.warningPixel)),
      );
    }
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
                      setState(() {
                        brightness = value;
                        _applyColorChanges();
                      });
                    },
                  ),
                  const SizedBox(height: 10),
                  DropdownButton<int>(
                    value: selectedEffect,
                    onChanged: _handleEffectChange,
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
                      width: 150, // smaller width for the pixel input
                      child: TextFormField(
                        controller: _pixelController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _applyPixelColor,
                    child: Text(context.l10n.applyPixel),
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

