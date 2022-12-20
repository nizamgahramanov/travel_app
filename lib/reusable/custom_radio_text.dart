import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_light_text.dart';

class CustomRadioText extends StatelessWidget {
  const CustomRadioText({
    super.key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final bool groupValue;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue) {
          onChanged(value);
        }
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<bool>(
              groupValue: groupValue,
              value: value,
              onChanged: (bool? newValue) {
                onChanged(newValue!);
              },
            ),
            AppLightText(
              text: label,
              size: 16,
              color: Colors.black,
              padding: EdgeInsets.zero,
              spacing: 0,
            ),
          ],
        ),
      ),
    );
  }
}
