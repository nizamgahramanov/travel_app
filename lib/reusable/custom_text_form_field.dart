import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    Key? key,
    this.controller,
    required this.keyboardType,
    this.onChanged,
    required this.onFieldSubmitted,
    this.onSaved,
    required this.textInputAction,
    this.suffixIcon,
    this.focusNode,
    this.obscureText = false,
    this.validator,

  }) : super(key: key);
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged? onSaved;
  final TextInputAction textInputAction;
  final Widget? suffixIcon;
  final FocusNode? focusNode;
  final bool obscureText;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction:textInputAction,
      obscureText: obscureText,
      onChanged: onChanged,
      focusNode: focusNode,
      validator: validator,
      onFieldSubmitted: onFieldSubmitted,
      decoration: InputDecoration(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          // borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: AppColors.buttonBackgroundColor,
            width: 2,
          ),
        ),
        suffixIcon: suffixIcon,
        suffixIconColor: AppColors.buttonBackgroundColor,
        // focusColor: AppColors.buttonBackgroundColor
      ),
      onSaved: onSaved,
    );
  }
}

// class BoxTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final FormFieldValidator<String> validator;
//   final bool obsecure;
//   final bool readOnly;
//   final VoidCallback onTap;
//   final VoidCallback onEditingCompleted;
//   final TextInputType keyboardType;
//   final ValueChanged<String> onChanged;
//   final bool isMulti;
//   final bool autofocus;
//   final bool enabled;
//   final String errorText;
//   final String label;
//   final Widget suffix;
//   final Widget prefix;
//
//   BoxTextField(
//       {Key key,
//         this.controller,
//         this.validator,
//         this.keyboardType = TextInputType.text,
//         this.obsecure = false,
//         this.onTap,
//         this.isMulti = false,
//         this.readOnly = false,
//         this.autofocus = false,
//         this.errorText,
//         @required this.label,
//         this.suffix,
//         this.prefix,
//         this.enabled = true,
//         this.onEditingCompleted,
//         this.onChanged})
//       : super(key: key);
