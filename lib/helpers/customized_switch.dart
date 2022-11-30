import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class CustomizedSwitch extends StatelessWidget {
  const CustomizedSwitch({
    super.key,
    required this.label,
    required this.subtitle,
    required this.padding,
    required this.value,
    required this.onChanged,
  });
  final String label;
  final String subtitle;
  final EdgeInsets padding;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: label,
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontFamily: "Montserrat"),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        debugPrint('Label has been tapped.');
                      },
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 14,
                      fontFamily: "Montserrat"),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: (bool newValue) {
              onChanged(newValue);
            },
          ),
        ],
      ),
    );
  }
}
