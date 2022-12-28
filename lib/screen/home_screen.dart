import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:travel_app/providers/destinations.dart';
import 'package:travel_app/widgets/staggered_grid_view.dart';

import 'add_destination_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void _goAddDestinationScreen() {
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.zero,
                        color: Colors.redAccent,
                        child: AppLightText(
                          text: 'home_title'.tr(),
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.normal,
                          spacing: 0,
                          padding: EdgeInsets.zero,
                          size: 13,
                          alignment: Alignment.centerLeft,
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        color: Colors.redAccent,
                        child: AppLightText(
                          text: 'explore_the_best_places_in_azerbaijan_msg'.tr(),
                          padding: EdgeInsets.zero,
                          spacing: 0,
                          size: 13,
                          alignment: Alignment.centerLeft,
                          textAlign: TextAlign.start,
                        ),
                      )
                    ],
                  ),
                ),
                CustomButton(
                  onTap: _goAddDestinationScreen,
                  buttonText: 'home_add_btn'.tr(),
                  borderRadius: 15,
                  buttonTextSize: 13,
                  height: 45,
                  buttonColor: AppColors.buttonBackgroundColor,
                  textColor: AppColors.whiteColor,
                  borderColor: AppColors.buttonBackgroundColor,
                  textPadding: const EdgeInsets.symmetric(horizontal: 10),
                  // icon: Container(
                  //   width: 22,
                  //   height: 22,
                  //   color: AppColors.buttonBackgroundColor,
                  //   margin: const EdgeInsets.only(right: 10),
                  //   child: const Icon(Icons.add),
                  // ),
                ),
                // CustomButton(onTap: onTap, buttonText: buttonText, borderRadius: borderRadius, borderColor: borderColor)
                // ElevatedButton.icon(
                //   onPressed: goToAddDestinationScreen,
                //   label: Text('home_add_btn'.tr()),
                //   icon: const Icon(Icons.add),
                // )
              ],
            ),
            SizedBox(
              height: 10,
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
