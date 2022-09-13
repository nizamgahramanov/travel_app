import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Profile Screen",
          style: TextStyle(color: AppColors.textColor2),
        ),
      ),
    );
  }
}
