import 'package:flutter/material.dart';

class AppLargeText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final TextAlign textAlign;
  final Alignment alignment;
  AppLargeText({
    Key? key,
    this.size = 30,
    required this.text,
    this.color = Colors.white,
    this.textAlign = TextAlign.center,
    this.alignment = Alignment.centerLeft
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: Align(
        alignment: alignment,
        child: Text(
          text,
          style: TextStyle(
            color: color,
            fontSize: size,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
          textAlign: textAlign,
        ),
      ),
    );
  }
}
