import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_button.dart';

class LoginSignUp extends StatefulWidget {
  const LoginSignUp({Key? key}) : super(key: key);

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://picsum.photos/id/237/200/300"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          // Container(child: ,)
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: AppLargeText(
              text: "Sign up now!",
              size: 35,
            ),
            
          ),
          SizedBox(height: 30,),
          AppLightText(text: "Make destinations favorite",color: AppColors.inputColor,),
          AppLightText(text: "Write a destination review",color: AppColors.inputColor,),
          Expanded(child: Container()),
          Container(
            child: CustomButton(
              borderRadius: 25,
              onTap: () {},
              buttonText: "Log in or Sign up",
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
