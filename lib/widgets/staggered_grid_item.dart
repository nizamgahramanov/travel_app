import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:travel_app/widgets/shimmer_effect.dart';

import '../helpers/app_colors.dart';

class StaggeredGridItem extends StatelessWidget {
  final String name;
  final String region;
  final String regionAz;
  final String photo;

  const StaggeredGridItem({
    required this.name,
    required this.region,
    required this.regionAz,
    required this.photo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("OHOROR");
    print(photo);

    var locale = context.locale.languageCode;
    return Container(
      // padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
        border: Border.all(
          color: Colors.grey,
          width: 0.1,
        ),
        color: AppColors.whiteColor,
      ),
      child: Column(
        children: [
          _buildImage(),
          const SizedBox(
            height: 8,
          ),
          _buildText(locale),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: CachedNetworkImage(
        height: 300,
        imageUrl: photo,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: ShimmerEffect.rectangular(
            height: 300,
            isCircle: false,
          ),
        ),
        errorWidget: (context, url, error) {
          return const Center(
            child: Icon(Icons.error, color: Colors.red),
          );
        },
      ),
    );
  }

  Widget _buildText(String locale) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: AppLightText(
            text: name,
            size: 15,
            color: AppColors.blackColor,
            fontWeight: FontWeight.bold,
            spacing: 2,
            padding: EdgeInsets.zero,
          ),
        ),
        const SizedBox(
          height: 2,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: CustomIconText(
            text: locale == 'az' ? regionAz : region,
            spacing: 3,
            size: 13,
            color: AppColors.buttonBackgroundColor,
            icon: Icon(
              Icons.location_on_outlined,
              size: 13,
              color: AppColors.buttonBackgroundColor,
            ),
            isIconFirst: true,
          ),
        ),
      ],
    );
  }
}

