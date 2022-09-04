import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';

class CustomButton extends StatelessWidget {
  VoidCallback onTap;
  String buttonText;
  double borderRadius;
  double margin;
  CustomButton({
    Key? key,
    required this.onTap,
    required this.buttonText,
    required this.borderRadius,
    this.margin=20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: AppColors.buttonBackgroundColor,
        border: Border.all(color: AppColors.inputColor),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: AppLargeText(
                text: buttonText,
                size: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
