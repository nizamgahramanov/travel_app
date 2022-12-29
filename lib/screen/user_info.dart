import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/reusable/custom_nested_scroll_view.dart';
import 'package:travel_app/reusable/custom_text_form_field.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';
import '../model/user_credentials.dart';
import 'main_screen.dart';

class UserInfo extends StatefulWidget {
  static const routeName = '/user_info';
  UserInfo({
    Key? key,
  }) : super(key: key);

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  final _form = GlobalKey<FormState>();
  final _lastnameFocusNode = FocusNode();
  final _firstnameFocusNode = FocusNode();
  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  bool _isShowSaveButton = false;

  void checkIfNameChanged(String text) {
    if (_firstnameController.text != '' && _lastnameController.text != '') {
      setState(() {
        _isShowSaveButton = true;
      });
    } else {
      setState(() {
        _isShowSaveButton = false;
      });
    }
  }

  @override
  void dispose() {
    _firstnameController.dispose();
    _lastnameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as UserCredentials;

    void _redirectUserToProfileScreen() {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => MainScreen(
            bottomNavIndex: 3,
          ),
        ),
        (Route<dynamic> route) => false,
      );
    }

    void _registerUser() async {
      if (_isShowSaveButton) {
        await AuthService().registerUser(
          context: context,
          firstName: _firstnameController.text,
          lastName: _lastnameController.text,
          email: args.email,
          password: args.password,
        );
        _redirectUserToProfileScreen();
      }
    }

    void saveForm() {
      FocusScope.of(context).unfocus();
      _form.currentState!.save();
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: CustomNestedScrollView(
        title: 'let\'s_get_know_app_bar_title'.tr(),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Form(
              key: _form,
              child: Column(
                children: [
                  Column(
                    children: [
                      AppLightText(
                        text: 'first_name'.tr(),
                        size: 18,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        spacing: 2,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Focus(
                        autofocus: true,
                        onFocusChange: (bool inFocus) {
                          if (inFocus) {
                            FocusScope.of(context)
                                .requestFocus(_firstnameFocusNode);
                          }
                        },
                        child: CustomTextFormField(
                          controller: _firstnameController,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          focusNode: _firstnameFocusNode,
                          onChanged: (value) => checkIfNameChanged(value),
                          onFieldSubmitted: (_) => FocusScope.of(context)
                              .requestFocus(_lastnameFocusNode),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Column(
                    children: [
                      AppLightText(
                        text: 'last_name'.tr(),
                        size: 18,
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        spacing: 2,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextFormField(
                        controller: _lastnameController,
                        keyboardType: TextInputType.name,
                        focusNode: _lastnameFocusNode,
                        onChanged: (value) => checkIfNameChanged(value),
                        onFieldSubmitted: (_) => saveForm(),
                        textInputAction: TextInputAction.done,
                        onSaved: (_) => _registerUser(),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isShowSaveButton
          ? CustomButton(
              buttonText: 'done_btn'.tr(),
              borderRadius: 15,
              horizontalMargin: 20,
              verticalMargin: 5,
              onTap: saveForm,
              borderColor: AppColors.primaryColorOfApp,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
