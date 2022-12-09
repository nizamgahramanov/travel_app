import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/services/auth_service.dart';
import '../helpers/app_colors.dart';
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
        print("isShow");
        _isShowSaveButton = false;
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
                    text: "Email",
                    size: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    spacing: 2,
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    autocorrect: true,
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
                    ),
                    onChanged: (character) => checkIfEmailChanged(character),
                    onFieldSubmitted: (_) {
                      saveForm();
                    },
                    onSaved: (value) {
                      checkEmailIsRegistered(value);
                    },
                  ),
                  // TextFormField(
                  //   textInputAction: TextInputAction.done,
                  //   keyboardType: TextInputType.emailAddress,
                  //   enableSuggestions: true,
                  //   autocorrect: true,
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     hintText: "Enter your email",
                  //     prefixIconColor: AppColors.buttonBackgroundColor,
                  //   ),
                  //   onFieldSubmitted: (_) {
                  //     saveForm();
                  //   },
                  //   onSaved: (value) {
                  //     checkEmailIsRegistered(value);
                  //   },
                  // ),
                  if (_isShowSaveButton)
                    const SizedBox(
                      height: 30,
                    ),
                  if (_isShowSaveButton)
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
                        spacing: 16,
                        text: "or",
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
                    buttonText: "Continue with Google",
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
          popButtonText: "Ok",
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
