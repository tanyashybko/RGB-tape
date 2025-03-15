import 'package:flutter/foundation.dart';
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
    if (kDebugMode) {
      print("Voice control started");
    }

    voiceApi.startListening((command) {
      if (kDebugMode) {
        print("Received voice command: $command");
      }
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
    if (kDebugMode) {
      print("Voice control stopped");
    }
  }

  Future<void> handleVoiceCommand(String command, BuildContext context) async {
    command = command.toLowerCase();
    if (kDebugMode) {
      print("Handling command: $command");
    }

    if (command == context.l10n.voiceTurnOn) {
      if (kDebugMode) {
        print("Command recognized: Turn on");
      }
      apiService.togglePower(1);
      return;
    } else if (command == context.l10n.voiceTurnOff) {
      if (kDebugMode) {
        print("Command recognized: Turn off");
      }
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
        if (kDebugMode) {
          print("Command recognized: Change color to ${entry.key}");
        }
        onColorChange(entry.value);
        return;
      }
    }

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

    for (var entry in effectWords.entries) {
      if (command.contains(entry.key)) {
        if (kDebugMode) {
          print("Command recognized: Apply effect ${entry.value}");
        }
        onEffectChange(entry.value);
        return;
      }
    }

    if (kDebugMode) {
      print("Effect command not matched in '$command'");
    }

    final Map<String, int> brightnessWords = {
      context.l10n.numOne: 1,
      context.l10n.numTwo: 2,
      context.l10n.numThree: 3,
      context.l10n.numFour: 4,
      context.l10n.numFive: 5,
      context.l10n.numSix: 6,
      context.l10n.numSeven: 7,
      context.l10n.numEight: 8,
      context.l10n.numNine: 9,
      context.l10n.numTen: 10,
      context.l10n.numEleven: 11,
      context.l10n.numTwelve: 12,
      context.l10n.numThirteen: 13,
      context.l10n.numFourteen: 14,
      context.l10n.numFifteen: 15,
      context.l10n.numSixteen: 16,
      context.l10n.numSeventeen: 17,
      context.l10n.numEighteen: 18,
      context.l10n.numNineteen: 19,
      context.l10n.numTwenty: 20,
      // Add all other numbers up to the highest level if needed
      context.l10n.numFifty: 50, // Example
    };

    for (var entry in brightnessWords.entries) {
      if (command.contains(entry.key)) {
        if (kDebugMode) {
          print("Command recognized: Set brightness to ${entry.value}");
        }
        onBrightnessChange(entry.value as double);
        return;
      }
    }

// If it didn't match the localized number words, try checking for the numeric value itself.
    RegExp numberPattern = RegExp(r'(\d+)'); // Matches any number
    Match? match = numberPattern.firstMatch(command);
    if (match != null) {
      int number = int.parse(match.group(1)!);
      if (number >= 1 &&
          number <= 100) { // Ensure the number is in a valid range
        if (kDebugMode) {
          print("Command recognized: Set brightness to $number");
        }
        onBrightnessChange(number as double);
        return;
      }
    }

    if (kDebugMode) {
      print("Brightness command not matched in '$command'");
    }


    final Map<String, Color> localizedColorMap = {
      context.l10n.voiceRed: const Color(0xFFFF0000),
      context.l10n.voiceBlue: const Color(0xFF0000FF),
      context.l10n.voiceGreen: const Color(0xFF00FF00),
      context.l10n.voiceYellow: const Color(0xFFFFFF00),
      context.l10n.voiceWhite: const Color(0xFFFFFFFF),
    };

    final pixelMatch = RegExp(
      r'\b' + context.l10n.voicePixel + r'\s+(\w+)\s+(\d+)\b',
      caseSensitive: false,
    ).firstMatch(command);

    if (pixelMatch != null) {
      final colorName = pixelMatch.group(1)?.toLowerCase() ?? '';
      final pixelNumber = int.tryParse(pixelMatch.group(2) ?? '');

      if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
        final selectedColor = localizedColorMap[colorName];

        if (selectedColor != null) {
          if (kDebugMode) {
            print("Command recognized: Change pixel $pixelNumber to $colorName");
          }

          // ⚡ Теперь запрос уходит на изменение цвета ПИКСЕЛЯ, а не всей ленты!
          await apiService.pixelApi.changePixelColor(
            pixelNumber,
            selectedColor.red,
            selectedColor.green,
            selectedColor.blue,
          );

          return;
        } else {
          if (kDebugMode) {
            print("Error: Unknown color '$colorName' in command '$command'");
          }
        }
      } else {
        if (kDebugMode) {
          print("Error: Invalid pixel number '$pixelNumber' in command '$command'");
        }
      }
    }

    if (command == context.l10n.voiceExit) {
      if (kDebugMode) {
        print("Command recognized: Logout");
      }
      onLogout();
    } else {
      if (kDebugMode) {
        print("Unknown command: '$command'");
      }
    }
  }
}