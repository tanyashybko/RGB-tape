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

  void startListening(BuildContext context) {
    onEnable();
    voiceApi.startListening((command) {
      handleVoiceCommand(command.toLowerCase(), context);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.voiceControlEnabled)),
    );
  }

  void stopListening() {
    onDisable();
    voiceApi.stopListening();
  }

  Future<void> handleVoiceCommand(String command, BuildContext context) async {
    if (command.contains(context.l10n.voiceTurnOn)) {
      apiService.togglePower(1);
    } else if (command.contains(context.l10n.voiceTurnOff)) {
      apiService.togglePower(0);
    } else if (command.contains(context.l10n.voiceBrightness)) {
      final brightnessMatch = RegExp(r'\d+').firstMatch(command);
      if (brightnessMatch != null) {
        final brightnessValue = double.tryParse(brightnessMatch.group(0)!);
        if (brightnessValue != null) {
          onBrightnessChange(brightnessValue);
        }
      }
    } else if (command.contains(context.l10n.voiceEffect)) {
      final effectMatch = RegExp(r'\d+').firstMatch(command);
      if (effectMatch != null) {
        final effectValue = int.tryParse(effectMatch.group(0)!);
        if (effectValue != null) {
          onEffectChange(effectValue);
        }
      }
    } else if (command.contains(context.l10n.voiceDisableEffect)) {
      onEffectChange(0);
      apiService.applyEffect(0);
    } else if (command.contains(context.l10n.voiceRed)) {
      onColorChange(Colors.red);
    } else if (command.contains(context.l10n.voiceGreen)) {
      onColorChange(Colors.green);
    } else if (command.contains(context.l10n.voiceBlue)) {
      onColorChange(Colors.blue);
    } else if (command.contains(context.l10n.voiceYellow)) {
      onColorChange(Colors.yellow);
    } else if (command.contains(context.l10n.voiceWhite)) {
      onColorChange(Colors.white);
    } else if (command.contains(context.l10n.voiceExit)) {
      onLogout();
    }
  }
}