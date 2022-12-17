import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class ErrorAndNoFavoriteScreen extends StatelessWidget {
  const ErrorAndNoFavoriteScreen({Key? key, required this.text, required this.path}) : super(key: key);
  final String text;
  final String path;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Column(
                children: [
                  SvgPicture.asset(path),
                  AppLightText(
                    spacing: 0,
                    text: text,
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
      );
  }
}
