import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/carousel_item.dart';
import 'package:provider/provider.dart';
import '../helpers/app_light_text.dart';
import '../helpers/destination_type.dart';
import '../model/circle_tab_indicator.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../screen/detail_screen.dart';

class HorizontalCarouselList extends StatefulWidget {
  @override
  State<HorizontalCarouselList> createState() => _HorizontalCarouselListState();
}

//StreamBuilder<List<Destination>>(
//         stream: providedData.destinationItemsAll,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           } else if (snapshot.connectionState == ConnectionState.active ||
//               snapshot.connectionState == ConnectionState.done) {
//             if (snapshot.hasError) {
//               return const Text('Error');
//             } else {
class _HorizontalCarouselListState extends State<HorizontalCarouselList>
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
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Text('Error');
            } else {
              print(snapshot.data);
              return Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TabBar(
                        labelPadding:
                            const EdgeInsets.only(left: 20, right: 20),
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
                                  spacing: 16,
                                  text: e.values.first,
                                  size: 14,
                                  color: AppColors.buttonBackgroundColor,
                                  padding: EdgeInsets.zero,
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
                    // padding: const EdgeInsets.only(left: 20),
                    width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: tabNames.map((e) {
                        Iterable<Destination> destinationIterable =
                            snapshot.data!.where(
                                (element) => element.type == e.keys.first.name);
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destinationIterable.length,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              print("CLICKED");
                              Navigator.of(context).pushNamed(
                                DetailScreen.routeName,
                                arguments: destinationIterable.elementAt(index),
                              );
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 15),
                              child: CarouselItem(
                                name: destinationIterable.elementAt(index).name,
                                photos: destinationIterable
                                    .elementAt(index)
                                    .photoUrl[0],
                                region:
                                    destinationIterable.elementAt(index).region,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: Text("SOMETHING UNKNOWN"),
            );
          }
        });
  }
}
