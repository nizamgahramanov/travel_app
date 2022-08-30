import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/stacked_carousel.dart';
import '../helpers/app_light_text.dart';
import '../model/circle_tab_indicator.dart';
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
              // labelColor: AppColors.textColor1,
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: CircleTabIndicator(
                color: AppColors.buttonBackgroundColor,
                radius: 4,
              ),
              // unselectedLabelColor:
              //     AppColors.mainTextColor.withOpacity(0.8),
              tabs: tab_names
                  .map(
                    (e) => Tab(
                      child: AppLightText(
                        text: e.values.first,
                        size: 14,
                        color: AppColors.buttonBackgroundColor,
                      ),
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
                            'id': destinations
                                .where(
                                    (element) => element.type == e.keys.first)
                                .elementAt(index)
                                .id,
                            // 'photos': destinations
                            //     .where(
                            //         (element) => element.type == e.keys.first)
                            //     .elementAt(index)
                            //     .photos,
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
                            .photos,
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


