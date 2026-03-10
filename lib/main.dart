import 'package:flutter/material.dart';
import 'package:via_app/utils/theme.dart';
import 'package:via_app/view/home_page.dart';
import 'package:via_app/view/login_page.dart';

void main() {
  runApp(const ViaApp());
}

class ViaApp extends StatelessWidget {
  const ViaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Via App',
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => LoginPage(),
      },
    );
  }
}
