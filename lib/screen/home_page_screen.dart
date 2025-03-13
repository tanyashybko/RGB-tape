import 'package:flutter/material.dart';
import 'package:rgb_tape/l10n/l10n.dart';
import 'login_screen.dart';
import 'main_control_screen.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

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
      )
          : null,
      body: Center(
        child: isLoggedIn ? const MainControlScreen() : const LoginScreen(),
      ),
    );
  }
}
