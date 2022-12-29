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
  const HomeScreen({required this.isLogin, Key? key}) : super(key: key);
  final bool isLogin;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  void _goAddDestinationScreen() {
    Navigator.of(context).pushNamed(AddDestinationScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<Destinations>(context);
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
                AppLightText(
                  text: 'home_title'.tr(),
                  color: AppColors.blackColor,
                  fontWeight: FontWeight.bold,
                  spacing: 0,
                  padding: EdgeInsets.zero,
                  size: 24,
                  alignment: Alignment.centerLeft,
                  textAlign: TextAlign.start,
                ),
                if (widget.isLogin)
                  CustomButton(
                    onTap: _goAddDestinationScreen,
                    buttonText: 'home_add_btn'.tr(),
                    borderRadius: 15,
                    buttonTextSize: 13,
                    height: 45,
                    buttonColor: AppColors.primaryColorOfApp,
                    textColor: AppColors.whiteColor,
                    borderColor: AppColors.primaryColorOfApp,
                    textPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ),
              ],
            ),
            const SizedBox(
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
