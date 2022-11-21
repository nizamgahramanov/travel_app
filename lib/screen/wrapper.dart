import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:travel_app/screen/profile_screen.dart';
import '../helpers/app_colors.dart';
import '../helpers/custom_tab_indicator.dart';
import 'algolia_search_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'login_signup_screen.dart';

class Wrapper extends StatefulWidget {
  final bool isLogin;
  int bottomNavIndex;
  static const routeName = '/wrapper';
  Wrapper({
    Key? key,
    required this.isLogin,
    required this.bottomNavIndex,
  }) : super(key: key);

  @override
  State<Wrapper> createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with SingleTickerProviderStateMixin {
  void _onItemTapped(int index) {
    setState(() {
      widget.bottomNavIndex = index;
    });
  }

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _icons = [
      const Icon(Icons.home_filled),
      const Icon(Icons.search),
      const Icon(Icons.favorite_rounded),
      if (widget.isLogin) const Icon(Icons.person) else const Icon(Icons.login)
    ];
    Map<int, Widget> screens = {
      0: HomeScreen(),
      1: const AlgoliaSearchScreen(),
      2: FavoriteScreen(),
      3: widget.isLogin ? ProfileScreen() : const LoginSignupScreen(),
    };
    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: SafeArea(bottom: false, child: screens[widget.bottomNavIndex]!),
      bottomNavigationBar: Container(
        height: 100,
        padding: const EdgeInsets.all(15),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            color: Colors.black.withOpacity(0.8),
            child: TabBar(
              onTap: _onItemTapped,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withOpacity(0.4),
              indicator: const CustomTabIndicator(
                color: Colors.white,
                isCircle: true,
                radius: 3,
              ),
              tabs: _icons
                  .map(
                    (icon) => Tab(
                      child: icon,
                    ),
                  )
                  .toList(),
              controller: _tabController,
            ),
          ),
        ),
      ),
      // bottomNavigationBar: GNav(
      //   tabs: [
      //     GButton(icon: Icons.home, text: "Home",),
      //     GButton(icon: Icons.search, text: "Search",),
      //     GButton(
      //       icon: Icons.favorite_border, text: "Favorite",
      //     ),
      //     GButton(
      //       icon: widget.isLogin ? Icons.person : Icons.login,
      //       text: widget.isLogin ? "Profile": "Log in",
      //     )
      //   ],
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: <BottomNavigationBarItem>[
      //     const BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //       ),
      //       label: 'Home',
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.search,
      //       ),
      //       label: 'Search',
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.favorite_border,
      //       ),
      //       label: 'Favorite',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: widget.isLogin
      //           ? const Icon(
      //               Icons.person,
      //             )
      //           : const Icon(
      //               Icons.login,
      //             ),
      //       label: widget.isLogin ? "Profile" : "Login",
      //     ),
      //   ],
      //   onTap: _onItemTapped,
      //   type: BottomNavigationBarType.fixed,
      //   currentIndex: widget.bottomNavIndex,
      //   selectedFontSize: 0,
      //   unselectedFontSize: 0,
      //   selectedItemColor: AppColors.buttonBackgroundColor,
      //   showUnselectedLabels: false,
      //   showSelectedLabels: true,
      //   // selectedIconTheme:IconThemeData() ,
      //   elevation: 0,
      //   unselectedItemColor: AppColors.buttonBackgroundColor.withOpacity(0.6),
      // ),
    );
  }
}
