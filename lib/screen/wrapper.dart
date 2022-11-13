import 'package:flutter/material.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/search_screen.dart';

import '../helpers/app_colors.dart';
import 'algolia_search_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'login_signup_screen.dart';

class Wrapper extends StatefulWidget {
  final bool isLogin;
  const Wrapper({Key? key, required this.isLogin}) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {

    Map<int, Widget> screens = {
      0: HomeScreen(),
      1: const AlgoliaSearchScreen(),
      2: FavoriteScreen(),
      3: widget.isLogin ? ProfileScreen() : const LoginSignupScreen(),
    };
    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
            ),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: widget.isLogin
                ? const Icon(
                    Icons.person,
                  )
                : const Icon(
                    Icons.login,
                  ),
            label: widget.isLogin ? "Profile" : "Login",
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
