import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/stacked_carousel.dart';
import '../model/dummy_data.dart';
import '../screen/detail_screen.dart';

class CircleIndicatorTabBar extends StatefulWidget {
  @override
  State<CircleIndicatorTabBar> createState() => _CircleIndicatorTabBarState();
}

class _CircleIndicatorTabBarState extends State<CircleIndicatorTabBar>
    with TickerProviderStateMixin {
  var tab_names = [
    {Destination_Type.place: 'Place'},
    {Destination_Type.forest: 'Forest'},
    {Destination_Type.lake: 'Lake'},
    {Destination_Type.waterwall: 'Waterwall'},
  ];

  @override
  Widget build(BuildContext context) {
    TabController _tabController =
        TabController(length: tab_names.length, vsync: this);
    return Column(
      children: [
        Container(
          child: Align(
            alignment: Alignment.centerLeft,
            child: TabBar(
              labelPadding: const EdgeInsets.only(left: 20, right: 20),
              labelColor: AppColors.buttonBackgroundColor,
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: CircleTabIndicator(
                color: AppColors.buttonBackgroundColor,
                radius: 4,
              ),
              unselectedLabelColor:
                  AppColors.buttonBackgroundColor.withOpacity(0.5),
              tabs: tab_names
                  .map(
                    (e) => Tab(
                      text: e.values.first,
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          height: 340,
          padding: const EdgeInsets.only(left: 20),
          width: double.maxFinite,
          child: TabBarView(
            children: tab_names
                .map(
                  (e) => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: destinations
                        .where((element) => element.type == e.keys.first)
                        .length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        print("CLICKED");
                        Navigator.of(context).pushNamed(
                          DetailScreen.routeName,
                          arguments: {
                            'name': destinations
                                .where(
                                    (element) => element.type == e.keys.first)
                                .elementAt(index)
                                .name,
                            'image_url': destinations
                                .where(
                                    (element) => element.type == e.keys.first)
                                .elementAt(index)
                                .image_url,
                          },
                        );
                      },
                      child: StackedCarousel(
                        destinations
                            .where((element) => element.type == e.keys.first)
                            .elementAt(index)
                            .name,
                        destinations
                            .where((element) => element.type == e.keys.first)
                            .elementAt(index)
                            .image_url,
                        destinations
                            .where((element) => element.type == e.keys.first)
                            .elementAt(index)
                            .region,
                      ),
                    ),
                  ),
                )
                .toList(),
            controller: _tabController,
          ),
        ),
      ],
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
