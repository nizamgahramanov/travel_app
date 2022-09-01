import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/model/dummy_data.dart';
import 'package:travel_app/widgets/circle_indicator_tab_bar.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  void initState() {
    // await FullScreen.enterFullScreen(FullScreenMode.EMERSIVE_STICKY);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20.0,
              ),
              height: MediaQuery.of(context).size.height * 0.05,
              // alignment: Alignment.topLeft,
              child: AppLargeText(
                text: 'Discover',
                color: AppColors.mainTextColor,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            CircleIndicatorTabBar(),
            const SizedBox(height: 40),
            Container(
              alignment: Alignment.topLeft,
              margin: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: 20,
              ),
              child: AppLargeText(
                text: "Top Destinations",
                size: 22,
                color: AppColors.mainTextColor,
              ),
            ),
            const SizedBox(height: 20),
            Container(
              height: 100,
              width: double.infinity,
              margin: const EdgeInsets.only(left: 20),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: destinations.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.inputColor,
                    ),
                    margin: EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              destinations[index].photos[0],
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AppLightText(text: "Caspian Sea"),
                              AppLightText(text: "Baku")
                            ],
                          ),
                        )
                      ],
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
