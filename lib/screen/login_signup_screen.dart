import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_button.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/screen/password_screen.dart';
import 'package:travel_app/services/auth_service.dart';

import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';

class LoginSignupScreen extends StatefulWidget {
  const LoginSignupScreen({Key? key}) : super(key: key);

  @override
  State<LoginSignupScreen> createState() => _LoginSignupScreenState();
}

class _LoginSignupScreenState extends State<LoginSignupScreen> {
  final _form = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Center(
        heightFactor: 1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _form,
              child: Column(
                children: [
                  AppLargeText(text: "Enter your email"),
                  TextFormField(
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.emailAddress,
                    enableSuggestions: true,
                    autocorrect: true,
                    decoration: InputDecoration(
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.buttonBackgroundColor,
                        ),
                      ),
                      labelText: "EMAIL",
                      labelStyle: const TextStyle(
                        color: Colors.black,
                      ),
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
                    borderRadius: 15,
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Divider(
                          height: 70,
                          indent: 20,
                          endIndent: 10,
                          thickness: 1.5,
                        ),
                      ),
                      Text("OR"),
                      Expanded(
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
                    buttonText: "Sign up with Google",
                    onTap: () {
                      AuthService().signInWithGoogle();
                    },
                    borderRadius: 15,
                  )
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
    isExistList = await _auth.fetchSignInMethodsForEmail(value);
    print(isExistList);
    if (isExistList.isEmpty) {
      //  go to password page
      Navigator.pushNamed(context, PasswordScreen.routeName, arguments: value);
    } else {
      //  send auth cde to email address
    }
  }
}
