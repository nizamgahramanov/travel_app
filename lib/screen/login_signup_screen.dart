import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/reusable/custom_text_form_field.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/custom_button.dart';
import '../helpers/utility.dart';
import '../services/firebase_firestore_service.dart';
import 'login_with_password_screen.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);
  static const routeName = '/login_signup';
  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  bool _isShowSaveButton = false;

  void checkIfEmailChanged(String character) {
    print("checkIfNameChanged");
    if (_emailController.text != '' &&
        RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
            .hasMatch(_emailController.text)) {
      // if(_emailController.text != ''){
      setState(() {
        print("isShow");
        print(_isShowSaveButton);
        _isShowSaveButton = true;
      });
    } else {
      setState(() {
        if (_isShowSaveButton) {
          print("isShow false");
          _isShowSaveButton = false;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        heightFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  AppLightText(
                    text: 'email_title'.tr(),
                    size: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    spacing: 2,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    onChanged: (character) => checkIfEmailChanged(character),
                    onFieldSubmitted: (_) {
                      saveForm();
                    },
                    onSaved: (value) {
                      checkEmailIsRegistered(value);
                    },
                  ),
                  if (_isShowSaveButton)
                    const SizedBox(
                      height: 30,
                    ),
                  if (_isShowSaveButton)
                    CustomButton(
                      buttonText: 'continue_btn'.tr(),
                      onTap: saveForm,
                      borderRadius: 20,
                    ),
                  Row(
                    children: <Widget>[
                      const Expanded(
                        child: Divider(
                          height: 70,
                          indent: 20,
                          endIndent: 10,
                          thickness: 1.5,
                        ),
                      ),
                      AppLightText(
                        spacing: 16,
                        text: 'or_divider'.tr(),
                        size: 12,
                        color: Colors.black87,
                        padding: EdgeInsets.zero,
                      ),
                      const Expanded(
                        child: Divider(
                          height: 70,
                          indent: 10,
                          endIndent: 20,
                          thickness: 1.5,
                        ),
                      ),
                    ],
                  ),
                  CustomButton(
                    buttonText: 'continue_with_google_btn'.tr(),
                    borderColor: Colors.black,
                    onTap: () {
                      AuthService().signInWithGoogle(context);
                    },
                    borderRadius: 20,
                    buttonColor: Colors.transparent,
                    textColor: Colors.black,
                    icon: Container(
                      width: 22,
                      height: 22,
                      margin: const EdgeInsets.only(right: 25),
                      child: SvgPicture.asset(
                          'assets/images/google-color-icon.svg'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void saveForm() {
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
  }

  void checkEmailIsRegistered(value) async {
    if (_isShowSaveButton) {
      List<String> isEmailExistList;
      print("value");
      print(value);
      bool provider = false;
      isEmailExistList = await _auth.fetchSignInMethodsForEmail(value.trim());
      final String? base16Encrypted =
          await FireStoreService().getUserPasswordFromFirestore(value);
      Map<String, dynamic> arguments = {"provider": provider, "email": value};
      print(isEmailExistList);
      print(base16Encrypted);
      if (isEmailExistList.isNotEmpty && base16Encrypted == null) {
        Utility.getInstance().showAlertDialog(
          popButtonColor: Colors.red,
          context: context,
          alertTitle: "Discrepancy on email",
          alertMessage:
              "There is a discrepancy on email. Please, contact support",
          popButtonText: 'back_btn'.tr(),
          onPopTap: () => Navigator.of(context).pop(),
        );
      } else {
        if (isEmailExistList.isEmpty) {
          //  go to password page
          Navigator.pushNamed(
            context,
            PasswordScreen.routeName,
            arguments: arguments,
          );
        } else {
          provider = true;
          //  send auth cde to email address
          if (isEmailExistList[0] == "google.com") {
            AuthService().signInWithGoogle(context);
          } else {
            Navigator.pushNamed(
              context,
              LoginWithPasswordScreen.routeName,
              arguments: arguments,
            );
          }
        }
      }
    }
  }
}
