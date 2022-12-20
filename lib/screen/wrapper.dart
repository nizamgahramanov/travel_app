import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/screen/profile_screen.dart';
import '../helpers/app_colors.dart';
import '../helpers/custom_buttom_navigation_bar.dart';
import '../helpers/custom_tab_indicator.dart';
import '../providers/language.dart';
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

  // set currentPage(int thePage) {
  //   widget.bottomNavIndex = thePage;
  //   _currentPageNotifier.value = thePage;
  // }
  // late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _tabController = TabController(vsync: this, length: 4);
  }

  @override
  Widget build(BuildContext context) {
    // _currentPageNotifier.addListener(() {
    //   print("DASD");
    //   print(_currentPageNotifier.value);
    //
    // });
    Language language = Provider.of<Language>(context);
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
      body: screens[widget.bottomNavIndex]!,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: widget.bottomNavIndex == 0 ? const Icon(
              Icons.home,
            ) : const Icon(
              Icons.home_outlined,
            ),
            label: 'home_bottom_nav_bar'.tr(),
          ),
          BottomNavigationBarItem(
            icon: widget.bottomNavIndex == 1
                ? const Icon(
                    Icons.saved_search_outlined,
                  )
                : const Icon(
                    Icons.search,
                  ),
            label: 'search_bottom_nav_bar'.tr(),
          ),
          BottomNavigationBarItem(
            icon: widget.bottomNavIndex == 2
                ? const Icon(
                    Icons.favorite_rounded,
                  )
                : const Icon(
                    Icons.favorite_border_outlined,
                  ),
            label: 'favorite_bottom_nav_bar'.tr(),
          ),
          BottomNavigationBarItem(
            icon: widget.isLogin
                ? widget.bottomNavIndex == 3
                    ? const Icon(
                        Icons.person,
                      )
                    : const Icon(
                        Icons.person_outline_rounded,
                      )
                : widget.bottomNavIndex == 3
                    ? const Icon(
                        Icons.login,
                      )
                    : const Icon(
                        Icons.login_outlined,
                      ),
            label: widget.isLogin ?'profile_bottom_nav_bar'.tr() : 'login_bottom_nav_bar'.tr(),
          ),
        ],
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: widget.bottomNavIndex,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        selectedItemColor: AppColors.buttonBackgroundColor,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        // selectedLabelStyle: TextStyle(color: Colors.black),
        // unselectedIconTheme: IconThemeData(color: Colors.black),
        // elevation: 10,
        unselectedItemColor: AppColors.buttonBackgroundColor.withOpacity(0.6),
      ),
    );
  }
}
