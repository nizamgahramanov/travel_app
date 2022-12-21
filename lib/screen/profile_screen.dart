import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_icon_text.dart';
import 'package:travel_app/model/firestore_user.dart';
import 'package:travel_app/screen/change_name.dart';
import 'package:travel_app/screen/wrapper.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';

import '../helpers/custom_button.dart';
import '../helpers/custom_list_tile.dart';
import '../helpers/utility.dart';
import '../providers/language.dart';
import '../reusable/custom_radio_text.dart';
import '../widgets/shimmer_effect.dart';
import 'change_email_screen.dart';
import 'change_password_screen.dart';
import 'error_and_no_favorite_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);
  static const routeName = '/profile';

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void listTileOnTap(
      String firstName, String lastName, String email, String? password) {
    // if (index == 0) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChangeNameScreen(
          firstName: firstName,
          lastName: lastName,
        ),
      ),
    );
    /* } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChangeEmailScreen(
            email: email,
            password: password,
          ),
        ),
      );
    }*/
  }

  void logout() {
    print('Logout');
    Navigator.of(context).pop();
    AuthService().signOut(context);
  }

  @override
  Widget build(BuildContext context) {
    String langCode = context.locale.languageCode;
    print("LLangCCDOO");
    print(langCode);
    User? result = FirebaseAuth.instance.currentUser;

    final List titleList = [
      'name_title'.tr(),
      'email_title'.tr(),
      'language_title'.tr(),
    ];
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height * 0.47,
            child: Stack(
              children: [
                Positioned(
                  height: MediaQuery.of(context).size.height * 0.47,
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
                  child: AppLightText(
                    text: 'profile_title'.tr(),
                    color: AppColors.whiteColor,
                    size: 32,
                    fontWeight: FontWeight.bold,
                    spacing: 2,
                    padding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                // const SizedBox(
                //   height: 8,
                // ),
                Card(
                  margin: const EdgeInsets.only(
                    left: 8,
                    top: 20,
                    right: 8,
                  ),
                  color: Colors.white,
                  child: StreamBuilder<FirestoreUser>(
                      stream: FireStoreService().getUserDataByUID(result!.uid),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomListTile(
                                title: titleList[0],
                                data: 'loading_msg'.tr(),
                                icon: const Icon(
                                    Icons.arrow_forward_ios_outlined),
                              ),
                              Divider(
                                height: 1,
                                color: AppColors.buttonBackgroundColor,
                              ),
                              CustomListTile(
                                  title: titleList[1],
                                  data: 'loading_msg'.tr(),
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                              Divider(
                                height: 1,
                                color: AppColors.buttonBackgroundColor,
                              ),
                              CustomListTile(
                                  title: titleList[2],
                                  data: 'loading_msg'.tr(),
                                  icon: const Icon(
                                      Icons.arrow_forward_ios_outlined)),
                            ],
                          );
                        } else if (snapshot.connectionState ==
                                ConnectionState.active ||
                            snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasError) {
                            return ErrorAndNoFavoriteScreen(
                              text: "something_went_wrong_error_msg".tr(),
                              path: "assets/svg/error.svg",
                            );
                          } else {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => listTileOnTap(
                                    snapshot.data!.firstName!,
                                    snapshot.data!.lastName!,
                                    snapshot.data!.email,
                                    snapshot.data!.password,
                                  ),
                                  child: CustomListTile(
                                      title: titleList[0],
                                      data:
                                          '${snapshot.data!.firstName!} ${snapshot.data!.lastName!}',
                                      icon: const Icon(
                                          Icons.arrow_forward_ios_outlined)),
                                ),
                                Divider(
                                  height: 1,
                                  color: AppColors.buttonBackgroundColor,
                                ),
                                CustomListTile(
                                    title: titleList[1],
                                    data: snapshot.data!.email,
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_outlined)),
                                Divider(
                                  height: 1,
                                  color: AppColors.buttonBackgroundColor,
                                ),
                                CustomListTile(
                                    title: titleList[2],
                                    data: context.locale.languageCode == 'az'
                                        ? 'azerbaijani'.tr()
                                        : 'english'.tr(),
                                    icon: const Icon(
                                        Icons.arrow_forward_ios_outlined)),
                              ],
                            );
                          }
                        } else {
                          return ErrorAndNoFavoriteScreen(
                            text: "something_went_wrong_error_msg".tr(),
                            path: "assets/svg/error.svg",
                          );
                        }
                      }),
                ),
                GestureDetector(
                  onTap: () {
                    Utility.getInstance().showAlertDialog(
                      context: context,
                      alertTitle: 'log_out_question'.tr(),
                      popButtonColor: AppColors.backgroundColorOfApp,
                      popButtonText: 'back_btn'.tr(),
                      onPopTap: () => Navigator.of(context).pop(),
                      isShowActionButton: true,
                      actionButtonText: 'log_out_btn'.tr(),
                      onTapAction: logout,
                      actionButtonColor: Colors.redAccent,
                      popButtonTextColor: AppColors.blackColor,
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 20,
                    ),
                    child: CustomListTile(
                      title: 'log_out_btn'.tr(),
                      icon: const Icon(
                        Icons.logout_rounded,
                        // size: 28,
                        // color: AppColors.blackColor38,
                      ),
                    ),
                  ),
                ),
                /*StreamBuilder<FirestoreUser>(
                    stream: FireStoreService().getUserDataByUID(result!.uid),
                    builder: (BuildContext context,
                        AsyncSnapshot<FirestoreUser> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return AppLightText(text: "Loading...", padding: EdgeInsets.zero, spacing: 0);
                      } else if (snapshot.connectionState ==
                              ConnectionState.active ||
                          snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.hasError) {
                          return ErrorAndNoFavoriteScreen(
                            text: "something_went_wrong_error_msg".tr(),
                            path: "assets/svg/error.svg",
                          );
                        } else {
                          return Expanded(
                            child: LimitedBox(
                              maxHeight: MediaQuery.of(context).size.height * .1,
                              child: Container(
                                color: Colors.red,
                                child: ListView.separated(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: false,
                                  itemBuilder: (context, index) {
                                    final data = titleList[index];
                                    return ListTile(
                                      trailing: snapshot.data!.password!=null? const Icon(Icons.edit_outlined):null,
                                      title: AppLightText(
                                        spacing: 16,
                                        text: data,
                                        size: 15,
                                        color: AppColors.blackColor.withOpacity(0.8),

                                        fontWeight: FontWeight.bold,
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
                                      onTap:snapshot.data!.password!=null? () => listTileOnTap(
                                        index,
                                        snapshot.data!.firstName!,
                                        snapshot.data!.lastName!,
                                        snapshot.data!.email,
                                        snapshot.data!.password,
                                      ):null,
                                    );
                                  },
                                  separatorBuilder: (_, __) => Divider(
                                    color: AppColors.buttonBackgroundColor,
                                  ),
                                  itemCount: titleList.length,
                                ),
                              ),
                            ),
                          );
                        }
                      } else {
                        return ErrorAndNoFavoriteScreen(
                          text: "something_went_wrong_error_msg".tr(),
                          path: "assets/svg/error.svg",
                        );
                      }
                    }),*/
                // Container(
                //   color: AppColors.whiteColor,
                //   child: ListTile(
                //     title: AppLightText(
                //       spacing: 16,
                //       text: 'language_title'.tr(),
                //       size: 15,
                //       color: Colors.black.withOpacity(.8),
                //       fontWeight: FontWeight.bold,
                //       padding: EdgeInsets.zero,
                //     ),
                //     trailing: const Icon(Icons.arrow_drop_down_sharp),
                //     subtitle: AppLightText(
                //       text: context.locale.languageCode == 'az'
                //           ? 'azerbaijani'.tr()
                //           : 'english'.tr(),
                //       spacing: 0,
                //       padding: EdgeInsets.zero,
                //       size: 14,
                //     ),
                //     onTap: () {
                //       showModalBottomSheet<void>(
                //         context: context,
                //         shape: const RoundedRectangleBorder(
                //           borderRadius: BorderRadius.vertical(
                //             top: Radius.circular(25.0),
                //           ),
                //         ),
                //         builder: (BuildContext context) {
                //           return Container(
                //             margin: const EdgeInsets.symmetric(vertical: 20),
                //             height: 230,
                //             child: RadioListBuilder(
                //               langCode: context.locale.languageCode,
                //             ),
                //           );
                //         },
                //       );
                //     },
                //   ),
                // ),
                // const SizedBox(
                //   height: 8,
                // ),
/*                GestureDetector(
                  onTap: () {
                    Utility.getInstance().showAlertDialog(
                      context: context,
                      alertTitle: 'log_out_question'.tr(),
                      popButtonColor: AppColors.backgroundColorOfApp,
                      popButtonText: 'back_btn'.tr(),
                      onPopTap: () => Navigator.of(context).pop(),
                      isShowActionButton: true,
                      actionButtonText: 'log_out_btn'.tr(),
                      onTapAction: logout,
                      actionButtonColor: Colors.redAccent,
                      popButtonTextColor: AppColors.blackColor,
                    );
                    // AuthService().signOut();
                  },
                  child: Container(
                    color: AppColors.whiteColor,
                    padding: const EdgeInsets.all(15),
                    child: CustomIconText(
                      text: 'log_out_btn'.tr(),
                      color: AppColors.blackColor.withOpacity(.8),
                      spacing: 0,
                      size: 15,
                      isIconFirst: false,
                      fontWeight: FontWeight.bold,
                      icon: const Icon(
                        Icons.logout_rounded,
                        size: 28,
                        color: AppColors.blackColor38,
                      ),
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                )*/
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RadioListBuilder extends StatefulWidget {
  const RadioListBuilder({Key? key, required this.langCode}) : super(key: key);
  final String langCode;
  @override
  RadioListBuilderState createState() {
    return RadioListBuilderState();
  }
}

class RadioListBuilderState extends State<RadioListBuilder> {
  bool _isRadioSelected = true;
  @override
  void initState() {
    super.initState();
    print("INIT STATE");
    print(widget.langCode);
    if (widget.langCode == 'en') {
      _isRadioSelected = false;
    } else {
      _isRadioSelected = true;
    }
  }

  void saveLanguage() {
    if (_isRadioSelected) {
      context.setLocale(const Locale('az', 'Latn'));
    } else {
      context.setLocale(const Locale('en', 'US'));
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Language language = Provider.of<Language>(context);
    return Column(
      // mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AppLightText(
          text: 'choose_language'.tr(),
          padding: const EdgeInsets.only(
            left: 25,
          ),
          size: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.blackColor,
          spacing: 0,
        ),
        const SizedBox(
          height: 20,
        ),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return CustomRadioText(
              label: index == 0 ? 'azerbaijani'.tr() : 'english'.tr(),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              value: index == 0 ? true : false,
              groupValue: _isRadioSelected,
              onChanged: (bool newValue) {
                setState(() {
                  _isRadioSelected = newValue;
                });
              },
            );
          },
          itemCount: 2,
        )),
        CustomButton(
          buttonText: 'confirm_btn'.tr(),
          borderRadius: 15,
          horizontalMargin: 20,
          onTap: () {
            saveLanguage();
            language.onLanguageChanged();
          },
        ),
      ],
    );
  }
}
