import 'package:flutter/material.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/search_screen.dart';

import '../helpers/app_colors.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List screens = [
    HomeScreen(),
    SearchScreen(),
    FavoriteScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,

      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
            ),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedFontSize: 0,
        unselectedFontSize: 0,
        selectedItemColor: AppColors.buttonBackgroundColor,
        showUnselectedLabels: false,
        showSelectedLabels: true,
        // selectedIconTheme:IconThemeData() ,
        elevation: 0,
        unselectedItemColor: AppColors.buttonBackgroundColor.withOpacity(0.6),
      ),
    );
  }
}
