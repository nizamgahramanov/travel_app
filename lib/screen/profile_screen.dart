import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/screen/change_name.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_large_text.dart';
import '../helpers/custom_switch.dart';
import '../helpers/utility.dart';
import 'change_email_screen.dart';
import 'change_password_screen.dart';
import 'dart:math' as math;

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';
  final List titleList = const [
    "Name",
    "Email Address",
    "Change Password",
  ];
  bool _enable = false;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void listTileOnTap(int index) {
    if (index == 0) {
      Navigator.of(context).pushNamed(ChangeNameScreen.routeName);
    } else if (index == 1) {
      Navigator.of(context).pushNamed(ChangeEmailScreen.routeName);
    } else {
      Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
    }
  }
  void logoutAction() {
    Navigator.of(context).pop();
    AuthService().signOut();

  }
  @override
  Widget build(BuildContext context) {
    User? result = FirebaseAuth.instance.currentUser;
    if (result != null) {
      var provider = result.providerData;
      print(")))))))))))))))))))))");
      print(provider[0].providerId);
    }
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.38,
            child: Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                    child: Image.asset(
                      "assets/images/profile_screen.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 50,
                  left: 20,
                  right: 20,
                  child: AppLargeText(
                    text: 'YOUR SETTINGS IN SEYR ET',
                    color: Colors.white,
                    size: 32,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  flex: 6,
                  child: Container(
                    color: Colors.white,
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final data = widget.titleList[index];
                        return ListTile(
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                          visualDensity:
                              const VisualDensity(horizontal: 0, vertical: -3),
                          trailing: const Icon(Icons.edit_outlined),
                          title: AppLightText(
                            text: data,
                            size: 16,
                            color: Colors.black,
                          ),
                          subtitle: AppLightText(
                            text: result!.email!,
                            size: 14,
                          ),
                          onTap: () => listTileOnTap(index),
                        );
                      },
                      separatorBuilder: (_, __) => Divider(
                        color: AppColors.buttonBackgroundColor,
                      ),
                      itemCount: widget.titleList.length,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  flex: 2,
                  child: Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 12.0, left: 16.0, bottom: 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppLightText(
                                text: "Language",
                                size: 20,
                                color: Colors.black,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomSwitch(
                                value: widget._enable,
                                onChanged: (bool val) {
                                  setState(() {
                                    widget._enable = val;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Flexible(
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.only(left: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 8,
                        ),
                        GestureDetector(
                          onTap: () {
                            Utility.getInstance().showAlertDialog(
                              context:context,
                              alertTitle:"Do want to log out?",
                              popButtonColor: Colors.red,
                              popButtonText: "Cancel",
                              onPopTap: () => Navigator.of(context).pop(),
                              isShowActionButton: true,
                              actionButtonText: "Log out",
                              onTapAction: logoutAction,
                              actionButtonColor: Colors.red
                            );
                            // AuthService().signOut();
                          },
                          child: AppLightText(
                            text: "Log out",
                            size: 18,
                            color: Colors.red,
                            isShowCheckMark: true,
                            icon: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.rotationY(math.pi),
                              child: const Icon(
                                Icons.logout_rounded,
                                size: 28,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
