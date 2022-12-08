import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  String buttonText;
  Color? buttonColor;
  double borderRadius;
  Color? borderColor;
  double horizontalMargin;
  double verticalMargin;
  Color? textColor;
  Widget? icon;

  CustomButton(
      {Key? key,
      required this.onTap,
      required this.buttonText,
      this.buttonColor,
      required this.borderRadius,
      this.borderColor,
      this.horizontalMargin = 0.0,
      this.verticalMargin = 0.0,
      this.textColor,
      this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin,vertical: verticalMargin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: buttonColor ?? AppColors.buttonBackgroundColor,
        border: borderColor == null
            ? Border.all(color: AppColors.inputColor)
            : Border.all(color: Colors.black),
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) icon!,
            Material(
              color: Colors.transparent,
              child: Container(
                // padding: const EdgeInsets.all(10),
                child: Center(
                  child: AppLightText(
                    spacing: 2,
                    text: buttonText,
                    size: 18,
                    color: textColor == null ? Colors.white : textColor!,
                    padding: EdgeInsets.zero,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
