import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;

  const AppButton({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.buttonBackgroundColor,
      ),
      child: TextButton(
        clipBehavior: Clip.antiAlias,
        onPressed: () {},
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Montserrat',
            color: AppColors.whiteColor,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
