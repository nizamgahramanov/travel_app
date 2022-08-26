import 'package:flutter/material.dart';
import 'package:travel_app/model/dummy_data.dart';
import 'package:travel_app/widgets/below_lined_tab_bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    // await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(

            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 0,horizontal: 5.0),
                height: MediaQuery.of(context).size.height * 0.05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Discover",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.search_outlined),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              BelowLinedTabBar(),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.05,
                alignment: Alignment.topLeft,
                // padding: EdgeInsets.only(left: 8),
                child: Text(
                  "Destination you can travel",
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              // SizedBox(height:  MediaQuery.of(context).size.height*0.05),
              Container(
                height: MediaQuery.of(context).size.height * 0.2,
                width: double.infinity,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: destinations.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(
                        left: 12,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      width: 120,
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        destinations[index].image_url,
                        scale: 1.0,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
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
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green[300],
      ),
    );
  }
}
