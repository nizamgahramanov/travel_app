import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/model/user_credentials.dart';
import 'package:travel_app/reusable/sliver_app_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';

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
  final _auth = FirebaseAuth.instance;

  String first_name = "";
  String last_name = "";

  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as UserCredentials;
    void _trySubmit() async {
      UserCredential userCredential;
      try {
        userCredential = await _auth.createUserWithEmailAndPassword(
          email: "NIZ",
          password: "1231354",
        );
      } catch (error) {
        print(error);
      }
    }
    void saveForm() {
      //check in firebase email is registered or not
      FocusScope.of(context).unfocus();
      _form.currentState!.save();
      _trySubmit();
    }

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: AppSliverAppBar(
                image_path:
                    'https://i.picsum.photos/id/877/200/300.jpg?hmac=kxnqPHdYgfVGqD41ArUXpM0IuUCD2GYefTwBboMDVeA',
                title_text: "Great time to discover",
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
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 0,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // Column(
                        //   children: widget.body_header
                        //       .map((e) => AppLightText(text: e))
                        //       .toList(),
                        // ),
                        AppLightText(text: "You made the right decision"),
                        AppLightText(text: "How shall we call you?"),
                        Form(
                          key: _form,
                          child: Column(
                            children: [
                              TextFormField(
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonBackgroundColor,
                                    ),
                                  ),
                                  labelText: "First Name",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  saveForm();
                                },
                                onSaved: (value) {
                                  first_name = value!;
                                },
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              TextFormField(
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonBackgroundColor,
                                    ),
                                  ),
                                  labelText: "Last Name",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  saveForm();
                                },
                                onSaved: (value) {
                                  last_name = value!;
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
                    height: 100,
                    color: AppColors.mainColor,
                  ),
                )
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
  }
}
