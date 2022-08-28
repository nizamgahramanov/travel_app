import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/widgets/detail_info.dart';

import '../helpers/app_large_text.dart';

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
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              height: 400,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                data['image_url']!,
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
              left: 15,
              top: 20,
              child: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                color: Colors.white,
              ),
            ),
            Positioned(
              top: 20,
              right: 15,
              child: IconButton(
                icon: const Icon(
                  Icons.favorite_border_outlined,
                ),
                color: Colors.white,
                onPressed: () {},
              ),
            ),
            Positioned(
              left: 25,
              bottom: 25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppLargeText(text: data['name']!,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.place,
                        color: Colors.white,
                      ),
                      Container(
                        alignment: Alignment.topLeft,
                        child: const Text(
                          'Qax seheri, Agcay kendi',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 25,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        width: 70,
                        height: 270,
                        color: Colors.white,
                        child: ListView.builder(
                          itemCount: 7,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.all(5.0),
                            width: 60,
                            height: 60,
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: Image.network(
                              data['image_url']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
//   const SizedBox(
//     height: 15,
//   ),
//   Row(
//     mainAxisAlignment: MainAxisAlignment.spaceAround,
//     children: [
//       DetailInfo(
//         title: 'Distance',
//         info: "54 km",
//       ),
//       DetailInfo(
//         title: "Duration",
//         info: "2.6 h",
//       ),
//       DetailInfo(
//         title: "Rating",
//         info: "3.6 k",
//       ),
//     ],
//   ),
//   const SizedBox(
//     height: 10,
//   ),
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

// class CircleTabIndicator extends Decoration {
//   final Color color;
//   double radius;
//   CircleTabIndicator({required this.color, required this.radius});
//   @override
//   BoxPainter createBoxPainter([VoidCallback? onChanged]) {
//
//     return _CirclePainter(color: color, radius: radius);
//   }
// }
//
// class _CirclePainter extends BoxPainter {
//   final Color color;
//   double radius;
//   _CirclePainter({required this.color, required this.radius});
//
//   @override
//   void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
//     Paint _paint = Paint();
//     _paint.color = color;
//     _paint.isAntiAlias = true;
//     final Offset circleOffset = Offset(
//         configuration.size!.width / 2 - radius / 2,
//         configuration.size!.height - radius);
//     canvas.drawCircle(offset + circleOffset, radius, _paint);
//   }
// }
