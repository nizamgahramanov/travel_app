import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/screen/advanced_search.dart';
import 'package:travel_app/screen/login_signup.dart';
import 'package:travel_app/screen/profile_screen.dart';
import 'package:travel_app/screen/search_screen.dart';
import 'package:travel_app/services/auth_service.dart';
import '../helpers/app_colors.dart';
import '../model/destination.dart';
import 'advanced_search_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'login_signup_screen.dart';

class MainScreen extends StatefulWidget {
  bool? isLogin;

  MainScreen({Key? key, favoriteList}) : super(key: key);
  static const routeName = '/main';
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  void didChangeDependencies() {
    // AuthService().onAuthStateChanged.listen((event) {
    //   print("EVENTTT");
    //   print(event);
    //   if (event != null) {
    //     widget.isLogin = true;
    //   } else {
    //     widget.isLogin = false;
    //   }
    // });
    super.didChangeDependencies();
  }
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, Widget> screens = {
      0: HomeScreen(),
      1: SearchScreen(),
      2: FavoriteScreen(),
      3: widget.isLogin! ? ProfileScreen() : const LoginSignupScreen(),
    };
    // return StreamBuilder(builder: (_,AsyncSnapshot<User?> snapshot){
    //   if(snapshot.connectionState == ConnectionState.active){
    //     final User? user = snapshot.data;
    //     return user==null ?
    //
    //   }
    // });
    // return Scaffold(
    //   backgroundColor: AppColors.mainColor,
    //   body: screens[_selectedIndex],
    //   bottomNavigationBar: BottomNavigationBar(
    //     items: <BottomNavigationBarItem>[
    //       const BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.home,
    //         ),
    //         label: 'Home',
    //       ),
    //       const BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.search,
    //         ),
    //         label: 'Search',
    //       ),
    //       const BottomNavigationBarItem(
    //         icon: Icon(
    //           Icons.favorite_border,
    //         ),
    //         label: 'Favorite',
    //       ),
    //       BottomNavigationBarItem(
    //         icon: widget.isLogin!
    //             ? const Icon(
    //                 Icons.person,
    //               )
    //             : const Icon(
    //                 Icons.login,
    //               ),
    //         label: widget.isLogin! ? "Profile" : "Login",
    //       ),
    //     ],
    //     onTap: _onItemTapped,
    //     type: BottomNavigationBarType.fixed,
    //     currentIndex: _selectedIndex,
    //     selectedFontSize: 0,
    //     unselectedFontSize: 0,
    //     selectedItemColor: AppColors.buttonBackgroundColor,
    //     showUnselectedLabels: false,
    //     showSelectedLabels: true,
    //     // selectedIconTheme:IconThemeData() ,
    //     elevation: 0,
    //     unselectedItemColor: AppColors.buttonBackgroundColor.withOpacity(0.6),
    //   ),
    // );
  }
}
