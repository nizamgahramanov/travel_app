import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class CustomSnackbar extends StatelessWidget {
  // const CustomSnackbar({Key? key}) : super(key: key);
  final String content;
  CustomSnackbar({required this.content});
  @override
  Widget build(BuildContext context) {
    return SnackBar(content: AppLightText(text: content,));
  }
}
