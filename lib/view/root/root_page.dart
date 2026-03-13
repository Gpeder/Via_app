import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:via_app/utils/color.dart';
import 'package:via_app/view/home_page.dart';
import 'package:via_app/view/map_page.dart';
import 'package:via_app/view/myaction_page.dart';
import 'package:via_app/view/profile_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int _selectIndex = 0;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: IndexedStack(
        index: _selectIndex,
        children: const [HomePage(), MapPage(), MyactionPage(), ProfilePage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectIndex,
        onTap: (index) {
          setState(() {
            _selectIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        iconSize: 24,
        selectedIconTheme: IconThemeData(color: AppColors.primary),
        unselectedIconTheme: IconThemeData(color: AppColors.gray200),
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.gray200,
        selectedLabelStyle: textTheme.bodySmall?.copyWith(
          color: AppColors.primary,
        ),
        unselectedLabelStyle: textTheme.bodySmall?.copyWith(
          color: AppColors.gray200,
        ),
        backgroundColor: AppColors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(FontAwesomeIcons.house),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(FontAwesomeIcons.map),
            ),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(FontAwesomeIcons.calendar),
            ),
            label: 'Minhas ações',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Icon(FontAwesomeIcons.user),
            ),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
}
