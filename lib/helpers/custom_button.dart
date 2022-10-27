import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  String buttonText;
  Color? buttonColor;
  double borderRadius;
  Color? borderColor;
  double margin;
  Color? textColor;
  Widget? icon;

  CustomButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    this.buttonColor,
    required this.borderRadius,
    this.borderColor,
    this.margin=0.0,
    this.textColor,
    this.icon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 60,
      width: double.infinity,
      margin:  EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: buttonColor ?? AppColors.buttonBackgroundColor,
        border: borderColor==null ? Border.all(color: AppColors.inputColor):Border.all(color: Colors.black),

      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon!=null)
            icon!,
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              child: Container(
                // padding: const EdgeInsets.all(10),
                child: Center(
                  child: AppLargeText(
                    text: buttonText,
                    size: 18,
                    color: textColor==null? Colors.white : textColor!,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
