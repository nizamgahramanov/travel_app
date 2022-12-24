import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/screen/main_screen.dart';

import '../helpers/constants.dart';
import '../helpers/custom_button.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    super.initState();
  }

  void goToMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          bottomNavIndex: 0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        decoration: BoxDecoration(
          color: AppColors.mainColor,
          image: const DecorationImage(
            image: AssetImage(startScreenImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * 0.1,
                child: AppLightText(
                  text: 'discover_the_land_of_fire'.tr(),
                  color: AppColors.whiteColor,
                  size: 32,
                  fontWeight: FontWeight.bold,
                  spacing: 0,
                  padding: EdgeInsets.zero,
                  alignment: Alignment.center,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(child: Container()),
              CustomButton(
                buttonText: 'get_started_btn'.tr(),
                onTap: goToMainScreen,
                borderRadius: 15,
                horizontalMargin: 20,
                verticalMargin: 20,
                borderColor: AppColors.backgroundColorOfApp,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
