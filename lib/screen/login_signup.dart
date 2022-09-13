import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/reusable/sliver_app_bar.dart';
import 'package:travel_app/screen/password_screen.dart';

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
  final _auth = FirebaseAuth.instance;
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
            body: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return <Widget>[
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: AppSliverAppBar(
                      image_path:
                          'https://i.picsum.photos/id/944/200/200.jpg?hmac=1Hdj8yjDsg6pbmgsiAGRdUQ8MA4hfi4uapepYyrMaGU',
                      title_text: "Login or Sign up",
                      innerBoxIsScrolled: innerBoxIsScrolled,
                    ),
                  ),
                ];
              },
              body: Builder(
                builder: (BuildContext context) {
                  return CustomScrollView(
                    slivers: [
                      SliverOverlapInjector(
                        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context,
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 0),
                          color: AppColors.mainColor,
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              AppLightText(
                                  text:
                                      "We will check if your email is already part of SIXT"),
                              SizedBox(
                                height: 40,
                              ),
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
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                AppColors.buttonBackgroundColor,
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
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: Container(
                          height: 130,
                          color: AppColors.mainColor,
                        ),
                      ),

                    ],
                  );
                },
              ),
            ),
            floatingActionButton: CustomButton(
              buttonText: "Continue",
              borderRadius: 15,
              margin: 20,
              onTap: saveForm,
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          );
        });
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


  @override
  Widget build(BuildContext context) {


    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(
              "https://i.picsum.photos/id/678/200/300.jpg?hmac=oO5BaTGKFZ00iWC6GR1arWVrbmu2-XmgYl9ub3C_ug4"),
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
          const SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}
