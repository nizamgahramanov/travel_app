import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/detail_info.dart';
import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/circle_tab_indicator.dart';
import '../model/destination.dart';
import 'package:provider/provider.dart';

import '../providers/destinations.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';
  Function toggleFavorite;
  DetailScreen(this.toggleFavorite, {Key? key}) : super(key: key);
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  int showImageIndex = 0;
  void verticalListItemClicked(int index) {
    setState(() {
      showImageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("Detail Screen");
    final providerData = Provider.of<Destinations>(context,listen: false);
    print(providerData);

    TabController _tabController = TabController(length: 2, vsync: this);
    final data = ModalRoute.of(context)!.settings.arguments as Destination;
    // final Destination destination = providerData.findById(data['id']!);
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.5,
              color: AppColors.mainColor,
              child: Stack(
                children: [
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      child: Image.network(
                        data.photo_url[showImageIndex],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    top: 40,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: AppColors.buttonBackgroundColor,
                      ),
                      child: Icon(
                        Icons.arrow_back,
                        color: AppColors.inputColor,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () => widget.toggleFavorite(data.id),
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: AppColors.buttonBackgroundColor,
                      ),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: AppColors.inputColor,
                        // ):Icon(
                        //   Icons.favorite,
                        //   color: AppColors.inputColor,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 20,
                    bottom: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(
                          text: data.name,
                          size: 22,
                          color: AppColors.inputColor,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.place,
                              color: Colors.white,
                            ),
                            Container(
                              alignment: Alignment.topLeft,
                              child: AppLightText(
                                text: data.region,
                                color: AppColors.inputColor,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    right: 20,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Container(
                        padding: EdgeInsets.zero,
                        width: 70,
                        height: MediaQuery.of(context).size.height * 0.37,
                        color: AppColors.inputColor,
                        child: ListView.builder(
                          itemCount: 2,
                          padding: EdgeInsets.zero,
                          itemBuilder: (context, index) => GestureDetector(
                            onTap: () => verticalListItemClicked(index),
                            child: showImageIndex == index
                                ? Container(
                                    margin: const EdgeInsets.all(1.5),
                                    width: 65,
                                    height: 65,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          width: 1.2,
                                          color: AppColors.buttonBackgroundColor
                                              .withOpacity(0.4),
                                        )),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        // scale:3,
                                        data.photo_url[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.all(5.0),
                                    width: 55,
                                    height: 55,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: Image.network(
                                        data.photo_url[0],
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 30,),
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.45,
              color: AppColors.mainColor,
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      DetailInfo(
                        title: 'Distance',
                        info: "54 km",
                      ),
                      DetailInfo(
                        title: "Duration",
                        info: "2.6 h",
                      ),
                      DetailInfo(
                        title: "Rating",
                        info: "3.6 k",
                      ),
                    ],
                  ),
                  Align(
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
                          AppColors.buttonBackgroundColor.withOpacity(0.7),
                      tabs: [
                        Tab(
                          child: AppLightText(
                            text: 'Overview',
                            size: 15,
                            color: AppColors.buttonBackgroundColor,
                          ),
                        ),
                        Tab(
                          child: AppLightText(
                            text: 'Review',
                            size: 15,
                            color: AppColors.buttonBackgroundColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 60,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: double.infinity,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        Container(
                          child: AppLightText(
                            text: data.overview,
                          ),
                        ),
                        Container(
                          child: AppLightText(
                            text:
                                "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relax and take a time. Something more interested an be motivated",
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const AppButton(text: "View on map"),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
