import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class AppLightText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final bool isShowIcon;
  final Widget? icon;
  final Alignment alignment;
  final EdgeInsets padding;
  final double spacing;
  AppLightText({
    Key? key,
    this.size = 16,
    required this.text,
    this.color = Colors.black38,
    this.isShowIcon = false,
    this.icon,
    this.alignment = Alignment.centerLeft,
    required this.padding,
    required this.spacing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      // color: Colors.amberAccent,
      child: Align(
        alignment: alignment,
        child: Wrap(alignment: WrapAlignment.center, spacing: spacing, children: [
          if (isShowIcon) icon!,
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: size,
              fontWeight: FontWeight.normal,
              fontFamily: 'Montserrat',
            ),
            // textAlign: textAlign,
          ),
        ]),
      ),
    );
  }
}
