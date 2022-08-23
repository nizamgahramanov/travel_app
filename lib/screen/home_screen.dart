import 'package:flutter/material.dart';
import 'package:travel_app/model/dummy_data.dart';
import 'package:travel_app/screen/detail_screen.dart';

import '../widgets/stacked_carousel.dart';

class HomeScreen extends StatefulWidget {
  List<Map<Destination_Type, String>> tab_names = [
    {Destination_Type.place: 'Place'},
    {Destination_Type.forest: 'Forest'},
    {Destination_Type.lake: 'Lake'},
    {Destination_Type.waterwall: 'Waterwall'},
  ];
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: widget.tab_names.length, vsync: this);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "Explore",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.person_outline),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Find a place for yourself",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: const EdgeInsets.only(left: 20, right: 20),
                labelColor: Colors.black,
                controller: _tabController,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(
                  color: Colors.lightGreen,
                  radius: 4,
                ),
                unselectedLabelColor: Colors.grey,
                tabs: widget.tab_names
                    .map((e) => Tab(
                          text: e.values.first,
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 350,
              width: double.infinity,
              child: TabBarView(
                children: widget.tab_names
                    .map(
                      (name) => Container(
                        width: double.infinity,
                        height: 350,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destinations.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              print("CLICKED");
                              Navigator.of(context).pushNamed(
                                DetailScreen.routeName,
                                arguments: {
                                  'name': destinations[index].name,
                                  'image_url': destinations[index].image_url
                                },
                              );
                            },
                            child: StackedCarousel(
                              destinations[index].name,
                              destinations[index].image_url,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList()

                // Text("There"),
                // Text('Bye'),
                // Text('Bye'),
                // Text('Bye'),
                ,
                controller: _tabController,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 8),
              child: Text(
                "Destination you can travel",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 120,
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
    );
  }
}

class CircleTabIndicator extends Decoration {
  final Color color;
  double radius;
  CircleTabIndicator({required this.color, required this.radius});
  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {

    return _CirclePainter(color: color, radius: radius);
  }
}

class _CirclePainter extends BoxPainter {
  final Color color;
  double radius;
  _CirclePainter({required this.color, required this.radius});

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    Paint _paint = Paint();
    _paint.color = color;
    _paint.isAntiAlias = true;
    final Offset circleOffset = Offset(
        configuration.size!.width / 2 - radius / 2,
        configuration.size!.height - radius);
    canvas.drawCircle(offset + circleOffset, radius, _paint);
  }
}
