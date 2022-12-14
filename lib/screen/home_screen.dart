import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/widgets/staggered_grid_view.dart';

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
        padding: const EdgeInsets.only(
          top: 20.0,
          left: 20.0,
          right: 20.0,
          bottom: 0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppLightText(
                  text: 'home_title'.tr(),
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  spacing: 2,
                  padding: EdgeInsets.zero,
                ),
                ElevatedButton.icon(
                  onPressed: goToAddDestinationScreen,
                  label: Text('home_add_btn'.tr()),
                  icon: const Icon(Icons.add),
                )
              ],
            ),
            Expanded(
              child: StaggeredGridView(),
            ),
          ],
        ),
      ),
    );
  }
}
