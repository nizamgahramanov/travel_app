import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/widgets/detail_info.dart';

import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/circle_tab_indicator.dart';

class DetailScreen extends StatefulWidget {
  static const routeName = '/detail';

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with TickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 2, vsync: this);
    final data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(data['name']!),
      // ),
      extendBodyBehindAppBar: true,
      extendBody: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.55,
              color: AppColors.mainColor,
              // decoration: const BoxDecoration(
              //   borderRadius: BorderRadius.only(
              //     bottomLeft: Radius.circular(15),
              //     bottomRight: Radius.circular(15),
              //   ),
              // ),
              child: Stack(
                children: [
                  Positioned(
                    height: MediaQuery.of(context).size.height * 0.55,
                    width: MediaQuery.of(context).size.width,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                      child: Image.network(
                        data['image_url']!,
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
                  //icon: const Icon(Icons.arrow_back),
                  Positioned(
                    top: 40,
                    right: 10,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: CircleBorder(),
                        padding: const EdgeInsets.all(10),
                        primary: AppColors.buttonBackgroundColor,
                      ),
                      child: Icon(
                        Icons.favorite_border_outlined,
                        color: AppColors.inputColor,
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
                          text: data['name']!,
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
                                text: 'Qax seheri, Agcay kendi',
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
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        padding: EdgeInsets.zero,
                        width: 70,
                        height: MediaQuery.of(context).size.height * 0.37,
                        color: AppColors.inputColor,
                        child: ListView.builder(
                          itemCount: 7,
                          padding: EdgeInsets.zero,
                          itemBuilder: (_, index) => Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.network(
                                data['image_url']!,
                                fit: BoxFit.cover,
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
                      children: [
                        Container(
                          child: AppLightText(
                            text:
                                "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relax and take a time. Something more interested an be motivated",
                          ),
                        ),
                        Container(
                          child: AppLightText(
                            text:
                                "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relax and take a time. Something more interested an be motivated",
                          ),
                        ),
                      ],
                      controller: _tabController,
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

//   Align(
//     alignment: Alignment.centerLeft,
//     child: TabBar(
//       labelPadding: const EdgeInsets.only(left: 20, right: 20),
//       labelColor: Colors.black,
//       controller: _tabController,
//       isScrollable: true,
//       indicatorSize: TabBarIndicatorSize.label,
//       indicator: CircleTabIndicator(
//         color: Colors.lightGreen,
//         radius: 4,
//       ),
//       unselectedLabelColor: Colors.grey,
//       tabs: [
//         const Tab(
//           text: 'Overview',
//         ),
//         const Tab(
//           text: 'Reviews',
//         ),
//       ],
//     ),
//   ),
//   const SizedBox(
//     height: 15,
//   ),
//   Container(
//     height: 80,
//     margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//     color: Colors.black12,
//     width: double.infinity,
//     child: TabBarView(
//       children: [
//         Container(
//           child: Text(
//             "Beautiful place with its amazing nature.Live a life. You can take simple cotage here. Just relax and take a time. Something more interested an be motivated",
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 16,
//             ),
//           ),
//         ),
//         const Text("There"),
//       ],
//       controller: _tabController,
//     ),
//   ),
//   SizedBox(
//     height: 30.0,
//   ),
//   TextButton.icon(
//     onPressed: () {},
//     icon: const Icon(Icons.map_sharp),
//     label: const Text("View map"),
//     style: ElevatedButton.styleFrom(
//       primary: Colors.black12,
//       fixedSize: Size(360, 60),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),
//     ),
//   )
// ],
