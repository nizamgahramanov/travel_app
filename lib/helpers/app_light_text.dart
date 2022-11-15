import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class AppLightText extends StatelessWidget {
  double size;
  final String text;
  final Color color;
  final bool isShowCheckMark;
  final Widget? icon;
  final Alignment alignment;
  AppLightText({
    Key? key,
    this.size = 16,
    required this.text,
    this.color = Colors.black38,
    this.isShowCheckMark = false,
    this.icon,
    this.alignment = Alignment.centerLeft,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      // color: Colors.amberAccent,
      child: Align(
        alignment: alignment,
        child: Wrap(alignment: WrapAlignment.center, spacing: 16, children: [
          if (isShowCheckMark) icon!,
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
