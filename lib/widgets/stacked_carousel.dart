import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/model/destination.dart';
import '../helpers/app_large_text.dart';
import '../helpers/app_light_text.dart';
import '../model/dummy_data.dart';

class StackedCarousel extends StatelessWidget {
  final String name;
  final String image_url;
  final String region;
  StackedCarousel(this.name, this.image_url, this.region);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: EdgeInsets.only(
            right: 15,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          width: 250,
          clipBehavior: Clip.antiAlias,
          child: Image.network(
            image_url,
            scale: 1.0,
            fit: BoxFit.fill,
          ),
        ),
        Positioned(
          left: 20,
          bottom: 20,
          right: 35,
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
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
