import 'package:flutter/material.dart';
import 'package:rgb_tape/l10n/l10n.dart';
import 'login_screen.dart';
import 'main_control_screen.dart';

class HomePageScreen extends StatefulWidget {
  final Function(Locale) onLanguageChange;

  const HomePageScreen({super.key, required this.onLanguageChange});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLoggedIn
          ? AppBar(
        title: Center(child: Text(context.l10n.appTitle)),
        backgroundColor: Colors.purple,
        actions: [
          PopupMenuButton<String>(
            onSelected: (String languageCode) {
              widget.onLanguageChange(Locale(languageCode));
            },
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'en',
                child: Text('English'),
              ),
              const PopupMenuItem(
                value: 'ar',
                child: Text('العربية'),
              ),
            ],
            icon: const Icon(Icons.language),
          ),
        ],
      )
          : null,
      body: Center(
        child: isLoggedIn ? const MainControlScreen() : const LoginScreen(),
      ),
    );
  }
}
