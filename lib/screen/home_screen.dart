import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/widgets/staggered_grid_view.dart';
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
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15, bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLargeText(
                  text: 'Discover',
                  color: AppColors.mainTextColor,
                ),
                ElevatedButton.icon(
                  onPressed: goToAddDestinationScreen,
                  label: const Text("Add"),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            Expanded(
              child: StaggeredGridView(),
            ),
            // const TopDestination(),
          ],
        ),
      ),
    );
  }
}
