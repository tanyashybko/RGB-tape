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

import '../api_methods/client_api.dart';

class MainControlScreen extends StatefulWidget {
  const MainControlScreen({super.key});

  @override
  State<MainControlScreen> createState() => _MainControlScreenState();
}

class _MainControlScreenState extends State<MainControlScreen> {
  late final ApiService apiService;
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
                      width: 120,
                      child: TextField(
                        controller: _pixelController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: context.l10n.pixel,
                          filled: true,
                          fillColor: Colors.white,
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _applyPixelColor,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(context.l10n.applyPixel),
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


