import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/widgets/circle_indicator_tab_bar.dart';
import 'package:provider/provider.dart';
import '../model/destination.dart';
import 'add_destination_screen.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void goToAddDestinationScreen(){
    Navigator.of(context).pushNamed(AddDestinationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print("HOMW SCREEN");
    print(context);
    final providedData = Provider.of<Destinations>(context).destinationItemsAll;
    print(providedData);
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

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
                ElevatedButton.icon(onPressed: goToAddDestinationScreen, label: Text("Add"), icon: Icon(Icons.add),)
              ],
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
                itemCount: providedData.length,
                itemBuilder: (context, index) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.inputColor,
                    ),
                    margin: const EdgeInsets.only(right: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          width: 120,
                          clipBehavior: Clip.antiAlias,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.network(
                              providedData[index].photo_url[0],
                              scale: 1.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 8),
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
