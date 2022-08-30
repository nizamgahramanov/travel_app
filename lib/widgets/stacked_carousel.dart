import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/model/destination.dart';
import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/dummy_data.dart';

class StackedCarousel extends StatelessWidget {
  final String name;
  final List<String> photos;
  final String region;
  StackedCarousel(this.name, this.photos, this.region);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 15,
          ),
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              photos[0],
              scale: 1.0,
              fit: BoxFit.fill,
            ),
          ),
        ),
        Positioned(
          left: 15,
          bottom: 15,
          right: 30,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: AppColors.inputColor.withOpacity(0.7),
            ),
            padding: EdgeInsets.only(left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppLargeText(
                    text: name,
                    size: 21,
                    color: AppColors.mainTextColor,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: AppLargeText(
                    text: region,
                    size: 16,
                    color: AppColors.buttonBackgroundColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
