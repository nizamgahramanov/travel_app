import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class DetailInfo extends StatelessWidget {
  final String title;
  final String info;
  DetailInfo({required this.title, required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      elevation: 5.0,
      color: AppColors.inputColor,
      child: Container(
        width: 80,
        height: 80,
        margin: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            AppLightText(
              text: title,
              size: 18,
            ),
            AppLargeText(
              text: info,
              size: 22,
              color: AppColors.buttonBackgroundColor,
            ),
          ],
        ),
      ),
    );
  }
}
