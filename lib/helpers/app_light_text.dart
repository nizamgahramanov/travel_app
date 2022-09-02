import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class AppLightText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final bool isShowCheckMark;

  AppLightText({
    Key? key,
    this.size = 16,
    required this.text,
    this.color = AppColors.textColor1,
    this.isShowCheckMark=false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(

      children: [
        Icon(Icons.check,color: AppColors.buttonBackgroundColor),
        Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: FontWeight.normal,
            fontFamily: 'Montserrat',
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
