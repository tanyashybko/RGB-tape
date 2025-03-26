import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rgb_tape/service/api_service.dart';
import 'package:rgb_tape/voice/voice_api.dart';
import 'package:rgb_tape/l10n/l10n.dart';

class VoiceCommandHandler {
  final ApiService apiService;
  final VoiceApi voiceApi;
  final void Function() onEnable;
  final void Function() onDisable;
  final void Function(Color) onColorChange;
  final void Function(double) onBrightnessChange;
  final void Function(int) onEffectChange;
  final void Function(int, Color) onPixelChange;
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
    required this.onPixelChange,
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

    if (kDebugMode) print("Voice control started");

    voiceApi.startListening(
          (command) async {
        if (kDebugMode) print("Received voice command: $command");

        stopListening();

        await handleVoiceCommand(command.toLowerCase(), context);

        Future.delayed(const Duration(milliseconds: 500), () {
          if (isListening) startListening(context);
        });
      },
      localeId: Localizations.localeOf(context).languageCode,
    );

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
      context.l10n.voiceRed.toLowerCase(): Colors.red,
      context.l10n.voiceGreen.toLowerCase(): Colors.green,
      context.l10n.voiceBlue.toLowerCase(): Colors.blue,
      context.l10n.voiceYellow.toLowerCase(): Colors.yellow,
      context.l10n.voiceWhite.toLowerCase(): Colors.white,
    };

    final numberWords = {
      context.l10n.numFirst.toLowerCase(): 1,
      context.l10n.numSecond.toLowerCase(): 2,
      context.l10n.numThird.toLowerCase(): 3,
      context.l10n.numFourth.toLowerCase(): 4,
      context.l10n.numFifth.toLowerCase(): 5,
      context.l10n.numSixth.toLowerCase(): 6,
      context.l10n.numSeventh.toLowerCase(): 7,
      context.l10n.numEighth.toLowerCase(): 8,
      context.l10n.numNinth.toLowerCase(): 9,
      context.l10n.numTenth.toLowerCase(): 10,
      context.l10n.numEleventh.toLowerCase(): 11,
      context.l10n.numTwelfth.toLowerCase(): 12,
      context.l10n.numThirteenth.toLowerCase(): 13,
      context.l10n.numFourteenth.toLowerCase(): 14,
      context.l10n.numFifteenth.toLowerCase(): 15,
      context.l10n.numSixteenth.toLowerCase(): 16,
      context.l10n.numSeventeenth.toLowerCase(): 17,
      context.l10n.numEighteenth.toLowerCase(): 18,
      context.l10n.numNineteenth.toLowerCase(): 19,
      context.l10n.numTwentieth.toLowerCase(): 20,
      context.l10n.numTwentyFirst.toLowerCase(): 21,
      context.l10n.numTwentySecond.toLowerCase(): 22,
    };

    String normalizeCommand(String command) {
      return command.replaceAll('ё', 'е');
    }

    String normalizedCommand = normalizeCommand(command);

    print("Normalized command: $normalizedCommand");

    RegExp pixelPattern = RegExp(
      r'(' + numberWords.keys.join(r'|') + r')\s*(пиксель|pixel)\s*(' +
          r'(красный|зелёный|синий|жёлтый|белый|фиолетовый|оранжевый|розовый|голубой|пурпурный|cyan|magenta|blue|yellow|white|red|green|blue)' +
          r')',
    );

    if (pixelPattern.hasMatch(normalizedCommand)) {
      final pixelMatch = pixelPattern.firstMatch(normalizedCommand);
      if (pixelMatch != null) {
        String pixelWord = pixelMatch.group(1)!.toLowerCase();
        int pixelNumber = numberWords[pixelWord]!;
        String color = pixelMatch.group(3)!.toLowerCase();

        if (colorMap.containsKey(color)) {
          if (kDebugMode) {
            print("Command recognized: Set pixel $pixelNumber to ${colorMap[color]}");
          }
          onPixelChange(pixelNumber, colorMap[color]!);
          return;
        } else {
          if (kDebugMode) {
            print("Unrecognized color: $color");
          }
        }
      }
    }

    if (kDebugMode) {
      print("Pixel command not matched in '$command'");
    }

    // final generalColorMatch = RegExp(
    //       r'\b(' + colorMap.keys.map(RegExp.escape).join('|') + r')\b',
    //       caseSensitive: false,
    //     ).firstMatch(command);
    //
    //     if (generalColorMatch != null) {
    //       final colorName = generalColorMatch.group(1)?.toLowerCase();
    //       final selectedColor = colorMap[colorName];
    //
    //       if (selectedColor != null) {
    //         if (kDebugMode) {
    //           print("✅ General color change recognized: $colorName");
    //           print("📡 Sending request to /color");
    //         }
    //
    //         await apiService.changeColor(
    //           selectedColor.red,
    //           selectedColor.green,
    //           selectedColor.blue,
    //         );
    //       } else {
    //         if (kDebugMode) {
    //           print("❌ Invalid general color: $colorName");
    //         }
    //       }
    //     }
    //   }

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
      context.l10n.numTwentyOne: 21,
      context.l10n.numTwentyTwo: 22,
      context.l10n.numTwentyThree: 23,
      context.l10n.numTwentyFour: 24,
      context.l10n.numTwentyFive: 25,
      context.l10n.numTwentySix: 26,
      context.l10n.numTwentySeven: 27,
      context.l10n.numTwentyEight: 28,
      context.l10n.numTwentyNine: 29,
      context.l10n.numThirty: 30,
      context.l10n.numThirtyOne: 31,
      context.l10n.numThirtyTwo: 32,
      context.l10n.numThirtyThree: 33,
      context.l10n.numThirtyFour: 34,
      context.l10n.numThirtyFive: 35,
      context.l10n.numThirtySix: 36,
      context.l10n.numThirtySeven: 37,
      context.l10n.numThirtyEight: 38,
      context.l10n.numThirtyNine: 39,
      context.l10n.numForty: 40,
      context.l10n.numFortyOne: 41,
      context.l10n.numFortyTwo: 42,
      context.l10n.numFortyThree: 43,
      context.l10n.numFortyFour: 44,
      context.l10n.numFortyFive: 45,
      context.l10n.numFortySix: 46,
      context.l10n.numFortySeven: 47,
      context.l10n.numFortyEight: 48,
      context.l10n.numFortyNine: 49,
      context.l10n.numFifty: 50,
      context.l10n.numFiftyOne: 51,
      context.l10n.numFiftyTwo: 52,
      context.l10n.numFiftyThree: 53,
      context.l10n.numFiftyFour: 54,
      context.l10n.numFiftyFive: 55,
      context.l10n.numFiftySix: 56,
      context.l10n.numFiftySeven: 57,
      context.l10n.numFiftyEight: 58,
      context.l10n.numFiftyNine: 59,
      context.l10n.numSixty: 60,
      context.l10n.numSixtyOne: 61,
      context.l10n.numSixtyTwo: 62,
      context.l10n.numSixtyThree: 63,
      context.l10n.numSixtyFour: 64,
      context.l10n.numSixtyFive: 65,
      context.l10n.numSixtySix: 66,
      context.l10n.numSixtySeven: 67,
      context.l10n.numSixtyEight: 68,
      context.l10n.numSixtyNine: 69,
      context.l10n.numSeventy: 70,
      context.l10n.numSeventyOne: 71,
      context.l10n.numSeventyTwo: 72,
      context.l10n.numSeventyThree: 73,
      context.l10n.numSeventyFour: 74,
      context.l10n.numSeventyFive: 75,
      context.l10n.numSeventySix: 76,
      context.l10n.numSeventySeven: 77,
      context.l10n.numSeventyEight: 78,
      context.l10n.numSeventyNine: 79,
      context.l10n.numEighty: 80,
      context.l10n.numEightyOne: 81,
      context.l10n.numEightyTwo: 82,
      context.l10n.numEightyThree: 83,
      context.l10n.numEightyFour: 84,
      context.l10n.numEightyFive: 85,
      context.l10n.numEightySix: 86,
      context.l10n.numEightySeven: 87,
      context.l10n.numEightyEight: 88,
      context.l10n.numEightyNine: 89,
      context.l10n.numNinety: 90,
      context.l10n.numNinetyOne: 91,
      context.l10n.numNinetyTwo: 92,
      context.l10n.numNinetyThree: 93,
      context.l10n.numNinetyFour: 94,
      context.l10n.numNinetyFive: 95,
      context.l10n.numNinetySix: 96,
      context.l10n.numNinetySeven: 97,
      context.l10n.numNinetyEight: 98,
      context.l10n.numNinetyNine: 99,
      context.l10n.numOneHundred: 100
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

    RegExp numberPattern = RegExp(r'(\d+)');
    Match? match = numberPattern.firstMatch(command);
    if (match != null) {
      int number = int.parse(match.group(1)!);
      if (number >= 1 &&
          number <= 100) {
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

    // final Map<String, int> numberWords = {
    //   context.l10n.numFirst: 1,
    //   context.l10n.numSecond: 2,
    //   context.l10n.numThird: 3,
    //   context.l10n.numFourth: 4,
    //   context.l10n.numFifth: 5,
    //   context.l10n.numSixth: 6,
    //   context.l10n.numSeventh: 7,
    //   context.l10n.numEighth: 8,
    //   context.l10n.numNinth: 9,
    //   context.l10n.numTenth: 10,
    //   context.l10n.numEleventh: 11,
    //   context.l10n.numTwelfth: 12,
    //   context.l10n.numThirteenth: 13,
    //   context.l10n.numFourteenth: 14,
    //   context.l10n.numFifteenth: 15,
    //   context.l10n.numSixteenth: 16,
    //   context.l10n.numSeventeenth: 17,
    //   context.l10n.numEighteenth: 18,
    //   context.l10n.numNineteenth: 19,
    //   context.l10n.numTwentieth: 20,
    //   context.l10n.numTwentyFirst: 21,
    //   context.l10n.numTwentySecond: 22
    // };
    //
    // final pixelMatch = RegExp(
    //   r'\b(первая|вторая|третья|четвёртая|пятая|шестая|седьмая|восьмая|девятая|десятая|одиннадцатая|двенадцатая|тринадцатая|четырнадцатая|пятнадцатая|шестнадцатая|семнадцатая|восемнадцатая|девятнадцатая|двадцатая|двадцать первая|двадцать вторая)\s+лампочка\s+(' + colorMap.keys.join('|') + r')\b',
    //   caseSensitive: false,
    // ).firstMatch(command);
    //
    // if (pixelMatch != null) {
    //   if (kDebugMode) {
    //     print("Pixel match found: ${pixelMatch.group(0)}");
    //   }
    //
    //   final pixelOrdinalString = pixelMatch.group(1)?.toLowerCase() ?? '';
    //   final pixelNumber = numberWords[pixelOrdinalString];
    //
    //   final colorName = pixelMatch.group(2)?.toLowerCase() ?? '';
    //
    //   if (pixelNumber != null && pixelNumber >= 1 && pixelNumber <= 22) {
    //     final selectedColor = colorMap[colorName];
    //
    //     if (selectedColor != null) {
    //       if (kDebugMode) {
    //         print("Command recognized: Change LED $pixelNumber to $colorName");
    //       }
    //
    //       await apiService.pixelApi.changePixelColor(
    //         pixelNumber,
    //         selectedColor.red,
    //         selectedColor.green,
    //         selectedColor.blue,
    //       );
    //
    //       return;
    //     }
    //   }
    // }

    void dispose() {
      stopListening();
      if (kDebugMode) print("VoiceCommandHandler disposed");
    }

    if (kDebugMode) {
      print("Unknown command: '$command'");
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