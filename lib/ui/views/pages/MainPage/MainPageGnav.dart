import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageNewBuild.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/AdminPageProfile.dart';
import 'package:emlak_project/ui/views/pages/AdminPage/adminPage.dart';
import 'package:emlak_project/ui/views/pages/MainPage/MainPageProfile.dart';
import 'package:emlak_project/ui/views/pages/MainPage/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../../cubit/adminpageCubit.dart';
import '../../viewUIsettings/viewUIsettings.dart';

class MainPageGnav extends StatefulWidget {
  const MainPageGnav({super.key});

  @override
  State<MainPageGnav> createState() => _MainPageGnavState();
}




class _MainPageGnavState extends State<MainPageGnav> {
  int _selectedIndex = 0;

  final List<Widget>_pages = const [
    Mainpage(),
    MainPageProfile(),
  ];


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminPageCubit()..konutlariListele(),
      child: Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
        bottomNavigationBar: Container(
          color: mainThemeColor,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
            child: GNav(
              gap: 8,
              backgroundColor: mainThemeColor,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.white12,
              padding: const EdgeInsets.all(15),
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              tabs: const [
                GButton(icon: Icons.home, text: "Anasayfa"),
                GButton(icon: Icons.person, text: "Profil"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
