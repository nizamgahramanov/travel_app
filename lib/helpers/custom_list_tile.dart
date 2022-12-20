import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_light_text.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    Key? key,
    required this.title,
    this.data,
  }) : super(key: key);
  final String title;
  final String? data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppLightText(
                spacing: 16,
                text: title,
                size: 15,
                color: AppColors.blackColor.withOpacity(0.8),
                fontWeight: FontWeight.bold,
                padding: EdgeInsets.zero,
              ),
              if(data!=null)
              AppLightText(
                spacing: 16,
                text: data!,
                // text:
                // '${snapshot.data!.firstName!} ${snapshot.data!.lastName!}',
                size: 14,
                padding: EdgeInsets.zero,
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_rounded),
        ],
      ),
    );
  }
}
