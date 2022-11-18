import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import '../helpers/app_large_text.dart';

class CarouselItem extends StatelessWidget {
  final String name;
  final String photos;
  final String region;
  CarouselItem({
    required this.name,
    required this.photos,
    required this.region,
  });
  @override
  Widget build(BuildContext context) {
    print("photo");
    print(photos);
    return Stack(
      children: [
        Container(
          // margin: const EdgeInsets.only(
          //   right: 15,
          // ),
          width: 250,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.network(
              photos,
              fit: BoxFit.cover,
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
            padding: const EdgeInsets.only(left: 10),
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
                    size: 10,
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
