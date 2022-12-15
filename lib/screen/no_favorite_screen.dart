import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class NoFavoriteScreen extends StatelessWidget {
  const NoFavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset("assets/svg/favorite_screen.svg"),
                  AppLightText(
                    spacing: 0,
                    text: 'no_favorites_yet_info'.tr(),
                    size: 18,
                    color: Colors.black54,
                    alignment: Alignment.center,
                    padding: EdgeInsets.zero,
                    fontWeight: FontWeight.bold,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
