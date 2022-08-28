import 'package:flutter/cupertino.dart';
import 'package:travel_app/helpers/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const   ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "Profile Screen",
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    );
  }
}
