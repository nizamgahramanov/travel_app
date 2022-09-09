import 'package:flutter/material.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password';
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  bool _pinned = true;
  bool _snap = false;
  bool _floating = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: _pinned,
            snap: _snap,
            floating: _floating,
            expandedHeight: 200,
            backgroundColor: AppColors.mainColor,

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  "PLEASE SET A PASSWORD TO SIGNUP",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ),
              background: Image.network(
                "https://i.picsum.photos/id/132/200/200.jpg?hmac=meVrCoOURNB7iKK3Mv-yuRrvxvXgv4h2vIRLM4sKwK4",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              width: double.maxFinite,
              height: MediaQuery.of(context).size.height * 0.7 + 100,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  AppLightText(text: "Welcome hjh@gmail.com"),
                  AppLightText(text: "Secure your new account with a password"),
                  SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: TextFormField(
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.buttonBackgroundColor,
                          ),
                        ),
                        labelText: "PASSWORD",
                        labelStyle: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) {
                        // saveForm();
                      },
                      onSaved: (value) {
                        // checkEmailIsRegistered(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: AppLightText(
                        size: 14,
                        text: "Password must meet the following requirements:"),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  AppLightText(
                    text: "Minimum of 8 characters",
                    isShowCheckMark: true,
                  ),
                  AppLightText(
                    text: "At least one lower case",
                    isShowCheckMark: true,
                  ),
                  AppLightText(
                    text: "At least one upper case",
                    isShowCheckMark: true,
                  ),
                  AppLightText(
                    text: "At least one number",
                    isShowCheckMark: true,
                  ),
                  AppLightText(
                    text: "At least one special character",
                    isShowCheckMark: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.mainColor,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: OverflowBar(
            overflowAlignment: OverflowBarAlignment.center,
            children: <Widget>[
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CustomButton(
                    buttonText: "Continue",
                    borderRadius: 25,
                    onTap: () {},

                    // onChanged: (bool val) {
                    //   setState(() {
                    //     _pinned = val;
                    //   });
                    // },
                    // value: _pinned,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      // SingleChildScrollView(
      //     child: Column(
      //   children: [
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.3,
      //       width: double.maxFinite,
      //       child: Stack(
      //         children: [
      //           Positioned(
      //             child: Image.network(
      //               "https://i.picsum.photos/id/454/200/200.jpg?hmac=N13wDge6Ku6Eg_LxRRsrfzC1A4ZkpCScOEp-hH-PwHg",
      //             ),
      //           ),
      //         ],
      //       ),
      //     ),
      //     Container(
      //       height: MediaQuery.of(context).size.height * 0.6,
      //       child: Form(
      //         key: _form,
      //         child: TextFormField(
      //           decoration: InputDecoration(
      //
      //             focusedBorder: UnderlineInputBorder(
      //               borderSide: BorderSide(
      //                 color: AppColors.buttonBackgroundColor,
      //               ),
      //             ),
      //             labelText: "Password",
      //             labelStyle: const TextStyle(
      //               color: Colors.black,
      //             ),
      //           ),
      //           textInputAction: TextInputAction.done,
      //           onFieldSubmitted: (_) {
      //             // saveForm();
      //           },
      //           onSaved: (value) {
      //             // checkEmailIsRegistered(value);
      //           },
      //         ),
      //       ),
      //     )
      //   ],
      // )),
    );
  }
}
