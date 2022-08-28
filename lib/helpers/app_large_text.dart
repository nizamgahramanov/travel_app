import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;

  AppLargeText({
    Key? key,
    this.size = 30,
    required this.text,
    this.color = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontSize: size,
        fontWeight: FontWeight.bold,
        fontFamily: 'Montserrat',
      ),
      textAlign: TextAlign.center,
    );
  }
}
