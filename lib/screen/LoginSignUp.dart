import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_button.dart';

class LoginSignUp extends StatefulWidget {
  LoginSignUp({Key? key}) : super(key: key);
  List<String> signupBenefit = const [
    "Make destinations favorite",
    "Write a destination review"
  ];

  @override
  State<LoginSignUp> createState() => _LoginSignUpState();
}

class _LoginSignUpState extends State<LoginSignUp> {
  final _form = GlobalKey<FormState>();
  void bottomSheetForSignIn(BuildContext context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25), topRight: Radius.circular(25)),
        ),
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.mainColor,
            appBar: AppBar(
              title: AppLargeText(
                text: "Log in or Sign up",
                size: 17,
                color: Colors.black,
              ),
              elevation: 0,
              backgroundColor: AppColors.mainColor,
            ),
            body: Container(
              margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  AppLightText(
                    text: "We will check if your email is already part of SIXT",
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _form,
                      child: TextFormField(
                        decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: AppColors.buttonBackgroundColor,
                            ),
                          ),
                          labelText: "Email",
                          labelStyle: const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        textInputAction: TextInputAction.done,
                        onFieldSubmitted: (_) {
                          saveForm();
                        },
                        onSaved: (value)  {
                          checkEmailIsRegistered(value);
                        },
                      ),
                    ),
                  ),
                  Expanded(child: Container()),
                  CustomButton(
                    onTap: saveForm,
                    buttonText: 'Continue',
                    borderRadius: 25,
                    margin: 0,
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          );
        });
  }

  void saveForm() {
    //check in firebase email is registered or not
    _form.currentState!.save();
  }
  void checkEmailIsRegistered(value){
    print("VAKUE");
    print(value);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage("https://picsum.photos/id/237/200/300"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          // Container(child: ,)
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: AppLargeText(
              text: "SIGN UP NOW!",
              size: 35,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: widget.signupBenefit
                  .map((e) => AppLightText(
                        text: e,
                        color: AppColors.inputColor,
                        isShowCheckMark: true,
                      ))
                  .toList(),
            ),
          ),

          Expanded(child: Container()),
          Container(
            child: CustomButton(
              borderRadius: 25,
              onTap: () => bottomSheetForSignIn(
                context,
              ),
              buttonText: "LOG IN OR SIGN UP",
            ),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
