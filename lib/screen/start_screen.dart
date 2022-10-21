import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_large_text.dart';
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

  void goToMainScreen() async {
    // var res = await AuthService().handleAuthState();
    // print(res);
    User? result = FirebaseAuth.instance.currentUser;
    print(result);
    bool isLogin=false;
    if(result!=null){
      isLogin=true;
    }
    print(isLogin);
    Navigator.of(context).pushReplacementNamed(MainScreen.routeName,arguments: isLogin);
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
            image: AssetImage('assets/images/sea.jpeg'),
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
                child: AppLargeText(
                  text: 'Discover the land of fire',
                  color: Colors.white,
                  size: 32,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(child: Container()),
              CustomButton(
                buttonText: "Get Started",
                onTap: goToMainScreen,
                borderRadius: 20,
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
