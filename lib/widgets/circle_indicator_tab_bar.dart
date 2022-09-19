import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/stacked_carousel.dart';
import 'package:provider/provider.dart';
import '../helpers/app_light_text.dart';
import '../helpers/destination_type.dart';
import '../model/circle_tab_indicator.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../screen/detail_screen.dart';

class CircleIndicatorTabBar extends StatefulWidget {
  @override
  State<CircleIndicatorTabBar> createState() => _CircleIndicatorTabBarState();
}

class _CircleIndicatorTabBarState extends State<CircleIndicatorTabBar>
    with TickerProviderStateMixin {
  var tabNames = [
    {DestinationType.place: 'Place'},
    {DestinationType.forest: 'Forest'},
    {DestinationType.lake: 'Lake'},
    {DestinationType.waterfall: 'Waterfall'},
  ];

  @override
  Widget build(BuildContext context) {
    final providerData = Provider.of<Destinations>(context);
    print("Circle Tab");
    print(providerData);
    TabController _tabController =
        TabController(length: tabNames.length, vsync: this);
    return StreamBuilder<List<Destination>>(
      stream: providerData.destinationItemsAll,
      builder: (context, snapshot) {
        if (snapshot.connectionState==ConnectionState.active) {
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
                  tabs: tabNames
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
                controller: _tabController,
                children: tabNames
                    .map(
                      (e) => ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: snapshot.data!
                            .where((element) => element.type == e.keys.first)
                            .length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () {
                            print("CLICKED");
                            var clickedItemId = snapshot.data!
                                .where(
                                    (element) => element.type == e.keys.first)
                                .elementAt(index)
                                .id;
                            print(clickedItemId);
                            Navigator.of(context).pushNamed(
                              DetailScreen.routeName,
                              arguments: {
                                'id': clickedItemId,
                              },
                            );
                          },
                          child: StackedCarousel(
                            snapshot.data!
                                .where((element) => element.type == e.keys.first)
                                .elementAt(index)
                                .name,
                            snapshot.data!
                                .where((element) => element.type == e.keys.first)
                                .elementAt(index)
                                .photo_url,
                            snapshot.data!
                                .where((element) => element.type == e.keys.first)
                                .elementAt(index)
                                .region,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        );
        }
        else if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(child: CircularProgressIndicator(),);
        }else{
          return Center(child: Text("ERRORO OCCURED"),);
        }

      }

    );
  }
}


