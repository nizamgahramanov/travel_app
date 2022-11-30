import 'package:flutter/material.dart';
import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';

class ChangeFirstnameScreen extends StatefulWidget {
  const ChangeFirstnameScreen({Key? key}) : super(key: key);
  static const routeName = '/change-firstname';
  @override
  State<ChangeFirstnameScreen> createState() => _ChangeFirstnameScreenState();
}

class _ChangeFirstnameScreenState extends State<ChangeFirstnameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColorOfApp,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                leading: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                backgroundColor: Colors.white,
                pinned: true,
                //floating: true,
                stretch: true,
                expandedHeight: 120.0,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Change Firstname",
                    // "Great time to discover",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
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
                    margin:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    // color: AppColors.bu,
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        // AppLightText(
                        //   spacing: 16,
                        //   text:
                        //       "Enter your new first name with your password. A confirmation link will be sent to your email address.",
                        //   size: 14,
                        //   padding: EdgeInsets.zero,
                        // ),
                        const SizedBox(
                          height: 20,
                        ),
                        Form(
                          // key: _form,
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.name,
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonBackgroundColor,
                                    ),
                                  ),
                                  labelText: "New First Name",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onFieldSubmitted: (_) {
                                  // saveForm();
                                },
                                onSaved: (value) {
                                  // checkEmailIsRegistered(value);
                                },
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.name,
                                enableSuggestions: true,
                                autocorrect: true,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonBackgroundColor,
                                    ),
                                  ),
                                  labelText: "New Last Name",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                onFieldSubmitted: (_) {
                                  // saveForm();
                                },
                                onSaved: (value) {
                                  // checkEmailIsRegistered(value);
                                },
                              ),
                              TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: AppColors.buttonBackgroundColor,
                                    ),
                                  ),
                                  labelText: "Current Password",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  // saveForm();
                                },
                                onSaved: (value) {
                                  // first_name = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: 130,
                //     color: AppColors.backgroundColorOfApp,
                //   ),
                // ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: CustomButton(
        buttonText: "SAVE",
        borderRadius: 15,
        margin: 20,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
