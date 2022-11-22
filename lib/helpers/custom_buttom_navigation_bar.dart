import 'package:flutter/material.dart';
import 'package:travel_app/helpers/custom_tab_indicator.dart';

class CustomButtomNavigatioinBar extends StatefulWidget {
  final bool isLogin;
  int? bottomNavIndex;
  ValueNotifier<int> _currentPageNotifier = ValueNotifier(0);
  CustomButtomNavigatioinBar({
    required this.isLogin,
    this.bottomNavIndex = 0,
  });

  @override
  State<CustomButtomNavigatioinBar> createState() =>
      _CustomButtomNavigatioinBarState();
}

class _CustomButtomNavigatioinBarState extends State<CustomButtomNavigatioinBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget._currentPageNotifier.value = widget.bottomNavIndex!;
    _tabController = TabController(vsync: this, length: 4);
  }

  void _onItemTapped(int index) {
    print("INDEX");
    print(index);
    setState(() {
      widget.bottomNavIndex = index;
      widget._currentPageNotifier.value = index;
    });
  }

  late TabController _tabController;
  @override
  Widget build(BuildContext context) {
    _tabController.index=widget.bottomNavIndex!;
    List<Widget> _icons = [
      const Icon(Icons.home_filled,size: 25,),
      const Icon(Icons.search, size: 25,),
      const Icon(Icons.favorite_rounded,size: 25,),
      if (widget.isLogin) const Icon(Icons.person,size: 25,) else const Icon(Icons.login,size: 25,)
    ];
    return Container(
      height: 80,
      // padding: const EdgeInsets.all(15),
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
    );
  }
}
