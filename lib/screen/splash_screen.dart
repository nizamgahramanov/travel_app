import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_colors.dart';

import '../helpers/app_large_text.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();
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
          image: DecorationImage(
              image: const AssetImage('assets/images/sea.jpeg'),
              fit: BoxFit.cover
              ),
        ),
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
                alignment: Alignment.topCenter,
                height: MediaQuery.of(context).size.height * 0.1,
                child: AppLargeText(
                  text: 'Discover the land of fire',
                  color: Colors.white,
                  size: 32,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              const AppButton(text: "Get Started"),
            ],
          ),
        ),
      ),
    );
  }
}
