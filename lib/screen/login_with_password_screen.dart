import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:encrypt/encrypt.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/model/firestore_user.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/en_de_cryption.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';

import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';
import 'main_screen.dart';

class LoginWithPasswordScreen extends StatefulWidget {
  static const routeName = '/login_with_password';

  String? password;

  LoginWithPasswordScreen({key}) : super(key: key);
  @override
  State<LoginWithPasswordScreen> createState() =>
      _LoginWithPasswordScreenState();
}

class _LoginWithPasswordScreenState extends State<LoginWithPasswordScreen> {
  final _login_with_password_form = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _passwordFocusNode = FocusNode();
  bool _isObscure = true;
  bool _isShowDoneButton = false;

  void saveForm() {
    //check in firebase email is registered or not
    FocusScope.of(context).unfocus();
    _login_with_password_form.currentState!.save();
  }

  void checkIfPasswordChanged(String text) {
    print("checkIfNameChanged");
    if (_passwordController.text != '') {
      setState(() {
        print("isShow");
        print(_isShowDoneButton);
        _isShowDoneButton = true;
      });
    } else {
      setState(() {
        print("isShow");
        print(_isShowDoneButton);
        _isShowDoneButton = false;
      });
    }
  }

  void toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  void checkPasswordCorrect(enteredPassword, context) async {
    //    1. Daxil olan userin emailinə vasitəsi ilə firestoredan məlumatlarını çəkirik
    //    2. Melumatlarda encrypt olunmuş passvordu decrypt edib userin daxil etiyi passvordla yoxlayiriq
    //    3. userin daxil etdiyi passvord dogrudursa home page yoneldirik
    //    4. dogru deyilse dialog gosteririk
    if(_isShowDoneButton){
      final args =
      ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
      final String? base16Encrypted =
      await FireStoreService().getUserPasswordFromFirestore(args['email']);
      // final String decryptedPassword =
      //     EnDeCryption().decryptWithAES(Encrypted.fromBase16(base16Encrypted!));
      bool isPasswordCorrect =
      EnDeCryption().isPasswordCorrect(enteredPassword, base16Encrypted!);
      // print(decryptedPassword);
      if (isPasswordCorrect) {
        AuthService().loginUser(
          context: context,
          email: args['email'],
          password: enteredPassword,
        );
        // I think this approach is not correct
        Navigator.pushNamedAndRemoveUntil(
            context, MainScreen.routeName, (route) => false);
      } else {
        Utility.getInstance().showAlertDialog(
          popButtonColor: Colors.red,
          context: context,
          alertTitle: "Password is correct",
          alertMessage: "Please check and try again",
          popButtonText: "Ok",
          onPopTap: () => Navigator.of(context).pop(),
        );
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppLargeText(
          text: "Welcome Back",
          size: 20,
          color: Colors.black,
        ),
        backgroundColor: AppColors.backgroundColorOfApp,
        elevation: 0.0,
        leading: InkWell(
          onTap: () {
            FocusScope.of(context).unfocus();
            Navigator.of(context).pop();
          },
          child: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          child: Column(
            children: [
              const SizedBox(
                height: 15.0,
              ),
              Container(
                height: 130,
                child: Form(
                  key: _login_with_password_form,
                  child: Column(
                    children: [
                      AppLargeText(
                        text: "Current Password",
                        size: 18,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        focusNode: _passwordFocusNode,
                        enableSuggestions: false,
                        autocorrect: false,
                        obscureText: _isObscure,
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
                          suffixIcon: GestureDetector(
                            onTap: () => toggleObscure(),
                            child: _isObscure
                                ? const Icon(Icons.remove_red_eye_outlined)
                                : const Icon(Icons.remove_red_eye),
                          ),
                          suffixIconColor: AppColors.buttonBackgroundColor,
                          // focusColor: AppColors.buttonBackgroundColor
                        ),
                        onChanged: (value) => checkIfPasswordChanged(value),
                        onFieldSubmitted: (_) {
                          saveForm();
                        },
                        onSaved: (value) {
                          checkPasswordCorrect(value, context);
                        },
                      ),
                    ],
                  ),

                  // child: TextFormField(
                  //   obscureText: true,
                  //   enableSuggestions: false,
                  //   autocorrect: false,
                  //   onChanged: (enteredText) {
                  //     setState(() {
                  //       widget.password = enteredText;
                  //     });
                  //     // initSearchDestination(enteredText);
                  //   },
                  //   onSaved: (value) {
                  //     checkPasswordCorrect(value, context);
                  //   },
                  //   decoration: InputDecoration(
                  //     filled: true,
                  //     border: OutlineInputBorder(
                  //       borderRadius: BorderRadius.circular(8.0),
                  //       borderSide: BorderSide.none,
                  //     ),
                  //     hintText: "Password",
                  //     suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                  //     suffixIconColor: AppColors.buttonBackgroundColor,
                  //   ),
                  // ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: _isShowDoneButton
          ? CustomButton(
              buttonText: "Done",
              borderRadius: 15,
              margin: 20,
              onTap: saveForm,
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
