import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';

import '../helpers/app_colors.dart';

class StaggeredGridItem extends StatelessWidget {
  final String name;
  final String region;
  final String photo;

  const StaggeredGridItem({
    required this.name,
    required this.region,
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(color: Colors.grey, width: 0.1),
        color: Colors.white,
      ),
      // color: Colors.white,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              photo,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: AppLargeText(
              text: name,
              size: 15,
              color: AppColors.mainTextColor,
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomIconText(
              text: region,
              spacing: 3,
              size: 13,
              color: AppColors.buttonBackgroundColor,
              icon: Icon(
                Icons.location_on_outlined,
                size: 13,
                color: AppColors.buttonBackgroundColor,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
    // return Container(
    //   height: 240,
    //   child: GridTile(
    //       child: ClipRRect(
    //         child: Image.network(
    //           photo,
    //           fit: BoxFit.cover,
    //         ),
    //       ),
    //       footer: GridTileBar(
    //         title: Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           mainAxisAlignment: MainAxisAlignment.center,
    //           children: [
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: AppLargeText(
    //                 text: name,
    //                 size: 21,
    //                 color: AppColors.mainTextColor,
    //               ),
    //             ),
    //             Align(
    //               alignment: Alignment.centerLeft,
    //               child: AppLargeText(
    //                 text: region,
    //                 size: 10,
    //                 color: AppColors.buttonBackgroundColor,
    //               ),
    //             ),
    //           ],
    //         ),
    //       )),
    // );
  }
}
