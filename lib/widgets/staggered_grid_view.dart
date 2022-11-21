import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/custom_tab_indicator.dart';
import 'package:travel_app/widgets/carousel_item.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/widgets/staggered_grid_item.dart';
import '../helpers/app_light_text.dart';
import '../helpers/destination_type.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../model/destination.dart';
import '../providers/destinations.dart';
import '../screen/detail_screen.dart';

class StaggeredGridView extends StatefulWidget {
  @override
  State<StaggeredGridView> createState() => _StaggeredGridViewState();
}

class _StaggeredGridViewState extends State<StaggeredGridView>
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
                  // const SizedBox(
                  //   height: 25,
                  // ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      labelPadding: const EdgeInsets.only(right: 22),
                      unselectedLabelColor: Colors.grey,
                      labelColor: Colors.black,
                      controller: _tabController,
                      isScrollable: true,
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator: CustomTabIndicator(
                        color: AppColors.buttonBackgroundColor,
                        isCircle: false,
                      ),
                      // unselectedLabelColor:
                      //     AppColors.mainTextColor.withOpacity(0.8),
                      tabs: tabNames
                          .map(
                            (e) => Tab(
                              child: Text(
                                e.values.first,
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    // height: 340,
                    // padding: const EdgeInsets.only(left: 20),
                    // width: double.maxFinite,
                    child: TabBarView(
                      controller: _tabController,
                      children: tabNames.map((e) {
                        Iterable<Destination> destinationIterable =
                            snapshot.data!.where(
                                (element) => element.type == e.keys.first.name);
                        return MasonryGridView.count(
                          crossAxisCount: 2,
                          itemCount: destinationIterable.length,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 12,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () {
                              print("CLICKED");
                              Navigator.of(context).pushNamed(
                                DetailScreen.routeName,
                                arguments: destinationIterable.elementAt(index),
                              );
                            },
                            child: StaggeredGridItem(
                              name: destinationIterable.elementAt(index).name,
                              region:
                                  destinationIterable.elementAt(index).region,
                              photo: destinationIterable
                                  .elementAt(index)
                                  .photoUrl[0],
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
