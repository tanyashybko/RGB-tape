import 'package:flutter/material.dart';
import 'package:rgb_tape/service/api_service.dart';
import 'package:rgb_tape/voice/voice_api.dart';
import 'package:rgb_tape/l10n/l10n.dart';

class VoiceCommandHandler {
  final ApiService apiService;
  final VoiceApi voiceApi;
  final VoidCallback onEnable;
  final VoidCallback onDisable;
  final Function(Color) onColorChange;
  final Function(double) onBrightnessChange;
  final Function(int) onEffectChange;
  final VoidCallback onLogout;

  bool isListening = false;

  VoiceCommandHandler({
    required this.apiService,
    required this.voiceApi,
    required this.onEnable,
    required this.onDisable,
    required this.onColorChange,
    required this.onBrightnessChange,
    required this.onEffectChange,
    required this.onLogout,
  });

  /// **Переключение голосового ввода**
  void toggleListening(BuildContext context) {
    if (isListening) {
      stopListening();
    } else {
      startListening(context);
    }
  }

  void startListening(BuildContext context) {
    isListening = true;
    onEnable();
    print("Voice control started");

    voiceApi.startListening((command) {
      print("Received voice command: $command");
      handleVoiceCommand(command.toLowerCase(), context);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.voiceControlEnabled)),
    );
  }

  void stopListening() {
    isListening = false;
    onDisable();
    voiceApi.stopListening();
    print("Voice control stopped");
  }

  Future<void> handleVoiceCommand(String command, BuildContext context) async {
    command = command.toLowerCase();
    print("Handling command: $command");

    if (command == context.l10n.voiceTurnOn) {
      print("Command recognized: Turn on");
      apiService.togglePower(1);
      return;
    } else if (command == context.l10n.voiceTurnOff) {
      print("Command recognized: Turn off");
      apiService.togglePower(0);
      return;
    }

    final colorMap = {
      context.l10n.voiceRed: Colors.red,
      context.l10n.voiceGreen: Colors.green,
      context.l10n.voiceBlue: Colors.blue,
      context.l10n.voiceYellow: Colors.yellow,
      context.l10n.voiceWhite: Colors.white,
    };

    for (var entry in colorMap.entries) {
      if (command.contains(entry.key)) {
        print("Command recognized: Change color to ${entry.key}");
        onColorChange(entry.value);
        return;
      }
    }

    /// **Исправленная обработка эффекта**
    final Map<String, int> effectWords = {
      context.l10n.numOne: 1,
      context.l10n.numTwo: 2,
      context.l10n.numThree: 3,
      context.l10n.numFour: 4,
      context.l10n.numFive: 5,
      context.l10n.numSix: 6,
      context.l10n.numSeven: 7,
      context.l10n.numEight: 8,
      context.l10n.numNine: 9,
      context.l10n.voiceDisableEffect: 0
    };

// Проверяем, есть ли совпадение в предопределённых командах
    for (var entry in effectWords.entries) {
      if (command.contains(entry.key)) {
        print("✅ Command recognized: Apply effect ${entry.value}");
        onEffectChange(entry.value);
        return;
      }
    }

// Если команда не распознана, выводим в лог
    print("⚠️ Effect command not matched in '$command'");

    /// **Исправленная обработка яркости**
    final brightnessMatch =
    RegExp(r'\b' + context.l10n.voiceBrightness + r'\s*(\d+)')
        .firstMatch(command);
    if (brightnessMatch != null) {
      final brightnessValue = double.tryParse(brightnessMatch.group(1) ?? '');
      if (brightnessValue != null) {
        print("Command recognized: Change brightness to $brightnessValue");
        onBrightnessChange(brightnessValue);
        return;
      } else {
        print("Error: Failed to parse brightness value from '$command'");
      }
    } else {
      print("Brightness command not matched in '$command'");
    }

    /// **Исправленная обработка пикселя**
    final pixelMatch =
    RegExp(r'\b' + context.l10n.voicePixel + r'\s*(\d+)\s*(\w+)')
        .firstMatch(command);
    if (pixelMatch != null) {
      final pixelNumber = int.tryParse(pixelMatch.group(1) ?? '');
      final colorName = pixelMatch.group(2) ?? '';

      if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
        final selectedColor = colorMap[colorName];

        if (selectedColor != null) {
          print("Command recognized: Change pixel $pixelNumber to $colorName");
          await apiService.pixelApi.changePixelColor(
            pixelNumber,
            selectedColor.red,
            selectedColor.green,
            selectedColor.blue,
          );
          return;
        } else {
          print("Error: Unknown color '$colorName' in command '$command'");
        }
      } else {
        print("Error: Invalid pixel number '$pixelNumber' in command '$command'");
      }
    } else {
      print("Pixel command not matched in '$command'");
    }

    if (command == context.l10n.voiceExit) {
      print("Command recognized: Logout");
      onLogout();
    } else {
      print("Unknown command: '$command'");
    }
  }
}
