import 'package:flutter/material.dart';

import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);
  static const routeName = "/change-password";
  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                elevation: 5,
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
                expandedHeight: 100.0,
                flexibleSpace: const FlexibleSpaceBar(
                  centerTitle: true,
                  title: Text(
                    "Change Password",
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

                        Form(
                          // key: _form,
                          child: Column(
                            children: [
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
                              const SizedBox(
                                height: 20,
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
                                  labelText: "New Password",
                                  labelStyle: const TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                textInputAction: TextInputAction.done,
                                onFieldSubmitted: (_) {
                                  // saveForm();
                                },
                                onSaved: (value) {
                                  // last_name = value!;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Align(
                          alignment: Alignment.topLeft,
                          child: AppLightText(
                            spacing: 16,
                            size: 14,
                            text:
                                "Password must meet the following requirements:",
                            padding: EdgeInsets.zero,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        AppLightText(
                          spacing: 16,
                          text: "Minimum of 8 characters",
                          isShowIcon: true,
                          padding: EdgeInsets.zero,
                        ),
                        AppLightText(
                          spacing: 16,
                          text: "At least one lower case",
                          isShowIcon: true,
                          padding: EdgeInsets.zero,
                        ),
                        AppLightText(
                          spacing: 16,
                          text: "At least one upper case",
                          isShowIcon: true,
                          padding: EdgeInsets.zero,
                        ),
                        AppLightText(
                          spacing: 16,
                          text: "At least one number",
                          isShowIcon: true,
                          padding: EdgeInsets.zero,
                        ),
                        AppLightText(
                          spacing: 16,
                          text: "At least one special character",
                          isShowIcon: true,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Container(
                //     height: 10,
                //     color: AppColors.mainColor,
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
        horizontalMargin: 20,
        onTap: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
