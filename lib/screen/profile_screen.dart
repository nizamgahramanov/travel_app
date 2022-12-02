import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';
import 'package:travel_app/helpers/customized_switch.dart';
import 'package:travel_app/model/firestore_user.dart';
import 'package:travel_app/reusable/custom_page_route.dart';
import 'package:travel_app/screen/change_name.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';

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
    "Email",
  ];
  bool _enable = false;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? result = FirebaseAuth.instance.currentUser;
  void listTileOnTap(int index, Map<String, String> map) {
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ChangeNameScreen(
                  firstName: map.values.first,
                  lastName: map.values.last,
                  uid: result?.uid,
                )),
      );
    } else if (index == 1) {
      Navigator.of(context).pushNamed(ChangeEmailScreen.routeName);
    } else {
      Navigator.of(context).pushNamed(ChangePasswordScreen.routeName);
    }
  }

  bool _isSelected = false;
  void logoutAction() {
    Navigator.of(context).pop();
    AuthService().signOut();
  }

  @override
  Widget build(BuildContext context) {

    // if (result != null) {
    //   var provider = result!.providerData;
    //   print(")))))))))))))))))))))");
    //   print(provider[0].providerId);
    //   result!.uid;
    // }
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Container(
            color: Colors.yellow,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.47,
            child: Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
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
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SizedBox(
                  height: 8,
                ),
                FutureBuilder<FirestoreUser>(
                    future: FireStoreService().getUserBuUID(result!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<FirestoreUser> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return const Text('Error');
                        } else {
                          return Expanded(
                            // color: Colors.white,
                            // width: double.maxFinite,
                            child: Container(
                              color: Colors.white,
                              child: ListView.separated(
                                padding: EdgeInsets.only(bottom: 0.0),
                                shrinkWrap: false,
                                itemBuilder: (context, index) {
                                  final data = widget.titleList[index];
                                  return ListTile(
                                    trailing: const Icon(Icons.edit_outlined),
                                    title: AppLightText(
                                      spacing: 16,
                                      text: data,
                                      size: 16,
                                      color: Colors.black,
                                      padding: EdgeInsets.zero,
                                    ),
                                    subtitle: index == 0
                                        ? AppLightText(
                                            spacing: 16,
                                            text:
                                                '${snapshot.data!.firstName!} ${snapshot.data!.lastName!}',
                                            size: 14,
                                            padding: EdgeInsets.zero,
                                          )
                                        : AppLightText(
                                            spacing: 16,
                                            text: snapshot.data!.email,
                                            size: 14,
                                            padding: EdgeInsets.zero,
                                          ),
                                    onTap: () => listTileOnTap(index, {
                                      'firstname': snapshot.data!.firstName!,
                                      'lastname': snapshot.data!.lastName!
                                    }),
                                  );
                                },
                                separatorBuilder: (_, __) => Divider(
                                  color: AppColors.buttonBackgroundColor,
                                ),
                                itemCount: widget.titleList.length,
                              ),
                            ),
                          );
                        }
                      } else {
                        return const Center(
                          child: Text("SOMETHING UNKNOWN"),
                        );
                      }
                    }),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  color: Colors.white,
                  child: CustomizedSwitch(
                      label: "Language",
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                      value: true,
                      onChanged: (bool newValue) {
                        setState(() {
                          _isSelected = newValue;
                        });
                      },
                      subtitle: 'Azerbaycan'),
                ),
                const SizedBox(
                  height: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Utility.getInstance().showAlertDialog(
                        context: context,
                        alertTitle: "Do want to log out?",
                        popButtonColor: Colors.red,
                        popButtonText: "Cancel",
                        onPopTap: () => Navigator.of(context).pop(),
                        isShowActionButton: true,
                        actionButtonText: "Log out",
                        onTapAction: logoutAction,
                        actionButtonColor: Colors.red);
                    // AuthService().signOut();
                  },
                  child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(15),
                    child: CustomIconText(
                      text: 'Log out',
                      color: Colors.redAccent,
                      spacing: 0,
                      size: 18,
                      isIconFirst: false,
                      icon: const Icon(
                        Icons.logout_rounded,
                        size: 28,
                        color: Colors.red,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
