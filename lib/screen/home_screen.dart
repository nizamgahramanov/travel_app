import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/widgets/horizontal_carousel_list.dart';
import '../widgets/top_destination.dart';
import 'add_destination_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void goToAddDestinationScreen() {
    Navigator.of(context).pushNamed(AddDestinationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    print("HOMW SCREEN");
    final providedData = Provider.of<Destinations>(context);
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
                ElevatedButton.icon(
                  onPressed: goToAddDestinationScreen,
                  label: const Text("Add"),
                  icon: const Icon(Icons.add),
                )
              ],
            ),

            HorizontalCarouselList(),
            const TopDestination(),
          ],
        ),
      ),
    );
  }
}
