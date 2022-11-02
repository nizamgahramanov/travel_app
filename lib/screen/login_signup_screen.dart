import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/screen/main_screen.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';
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
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Enter your email",
                      prefixIconColor: AppColors.buttonBackgroundColor,
                    ),
                    onFieldSubmitted: (_) {
                      saveForm();
                    },
                    onSaved: (value) {
                      checkEmailIsRegistered(value);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                    buttonText: "Continue",
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
                        text: "or",
                        size: 12,
                        color: Colors.black87,
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
                    buttonText: "Continue with Google",
                    borderColor: Colors.black,
                    onTap: () {
                      AuthService().signInWithGoogle();
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
    //check in firebase email is registered or not
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
  }

  void checkEmailIsRegistered(value) async {
    List<String> isExistList;
    print("value");
    print(value);
    bool provider = false;
    isExistList = await _auth.fetchSignInMethodsForEmail(value);
    Map<String, dynamic> arguments = {"provider": provider, "email": value};
    print(isExistList);
    if (isExistList.isEmpty) {
      //  go to password page
      Navigator.pushNamed(context, PasswordScreen.routeName,
          arguments: arguments);
    } else {
      provider = true;
      //  send auth cde to email address
      // AuthService.customSnackBar(content: "Thank you for being our valuable member");
      if (isExistList[0] == "google.com") {
        AuthService().signInWithGoogle();
      } else {
        Navigator.pushNamed(context, LoginWithPasswordScreen.routeName,
            arguments: arguments);
      }
    }
  }
}
