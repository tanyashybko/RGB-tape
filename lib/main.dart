import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rgb_tape/screen/home_page_screen.dart';
import 'package:rgb_tape/screen/login_screen.dart';
import 'package:rgb_tape/screen/main_control_screen.dart';
import 'l10n/l10n.dart';
import 'localization/locale_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: Consumer<LocaleProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            locale: provider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            initialRoute: '/home',
            routes: {
              '/login': (context) => const LoginScreen(),
              '/home': (context) => HomePageScreen(onLanguageChange: provider.setLocale),
              '/control': (context) => const MainControlScreen(),
            },
          );
        },
      ),
    );
  }
}
