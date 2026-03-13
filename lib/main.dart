import 'package:flutter/material.dart';
import 'package:via_app/utils/theme.dart';
import 'package:via_app/view/confirmation_page.dart';
import 'package:via_app/view/detailcard_page.dart';
import 'package:via_app/view/home_page.dart';
import 'package:via_app/view/login_page.dart';
import 'package:via_app/view/map_page.dart';
import 'package:via_app/view/myaction_page.dart';
import 'package:via_app/view/profile_page.dart';
import 'package:via_app/view/root/root_page.dart';
import 'package:via_app/view/selectdate_page.dart';

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
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        '/root': (context) => const RootPage(),
        '/home': (context) => const HomePage(),
        '/detailcard': (context) => const DetailcardPage(),
        '/selectdate': (context) => const SelectdatePage(),
        '/confirmation': (context) => const ConfirmationPage(),
        '/map': (context) => const MapPage(),
        '/myaction' : (context) => const MyactionPage(),
        '/profile' : (context) => const ProfilePage(),

      },
    );
  }
}
