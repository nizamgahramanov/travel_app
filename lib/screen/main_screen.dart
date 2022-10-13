import 'package:flutter/material.dart';
import 'package:travel_app/screen/login_signup.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/search_screen.dart';
import '../helpers/app_colors.dart';
import '../model/destination.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';

class MainScreen extends StatefulWidget {
  final List<Destination> favoriteList;
  bool isLogin;
  MainScreen({Key? key, required this.favoriteList, this.isLogin = false})
      : super(key: key);
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  late Map screens;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  void initState() {
    screens = {
      0: HomeScreen(),
      1: SearchScreen(),
      2: FavoriteScreen(
        favoriteList: widget.favoriteList,
      ),
      3: LoginSignUp(),
      4: const ProfileScreen(),
    };
    if (widget.isLogin) {
      screens.removeWhere((key, value) => key==3);
      screens.removeWhere((key, value) => key==4);
      screens[3]=const ProfileScreen();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
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
              label: widget.isLogin ? "Profile" : "Login"),
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
