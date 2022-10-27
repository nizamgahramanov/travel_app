import 'package:flutter/material.dart';
import 'package:travel_app/model/user_credentials.dart';
import 'package:travel_app/reusable/sliver_app_bar.dart';
import 'package:travel_app/screen/user_info.dart';
import '../helpers/app_colors.dart';
import '../helpers/app_light_text.dart';
import '../helpers/custom_button.dart';
import '../reusable/custom_page_route.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password';
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _form = GlobalKey<FormState>();

  void saveForm() {
    //check in firebase email is registered or not
    FocusScope.of(context).unfocus();
    _form.currentState!.save();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("args");
    print(args);
    void checkPasswordIsValid(value) async {
      print(value);
      // Navigator.of(context).push(CustomPageRoute(child: UserInfo()));
      //  go to password page
      if (args['provider']) {

      } else {
        Navigator.pushNamed(
          context,
          UserInfo.routeName,
          arguments: UserCredentials(
            args['email'],
            value,
          ),
        );
      }
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
                    'https://i.picsum.photos/id/132/200/200.jpg?hmac=meVrCoOURNB7iKK3Mv-yuRrvxvXgv4h2vIRLM4sKwK4',
                title_text: "Please set a password",
                innerBoxIsScrolled: innerBoxIsScrolled,
              ),
            ),
          ];
        },
        body: Builder(builder: (BuildContext context) {
          return CustomScrollView(
            slivers: [
              SliverOverlapInjector(
                handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                  context,
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  width: double.maxFinite,
                  height: MediaQuery.of(context).size.height * 0.7 + 60,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      AppLightText(text: "Welcome ${args['email']}"),
                      AppLightText(
                          text: "Secure your new account with a password"),
                      const SizedBox(
                        height: 30,
                      ),
                      Form(
                        key: _form,
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
                            saveForm();
                          },
                          onSaved: (value) {
                            checkPasswordIsValid(value);
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
                            text:
                                "Password must meet the following requirements:"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppLightText(
                        text: "Minimum of 8 characters",
                        isShowCheckMark: true,
                        icon: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(Icons.check),
                        ),
                      ),
                      AppLightText(
                        text: "At least one lower case",
                        isShowCheckMark: true,
                        icon: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(Icons.check),
                        ),
                      ),
                      AppLightText(
                        text: "At least one upper case",
                        isShowCheckMark: true,
                        icon: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(Icons.check),
                        ),
                      ),
                      AppLightText(
                        text: "At least one number",
                        isShowCheckMark: true,
                        icon: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(Icons.check),
                        ),
                      ),
                      AppLightText(
                        text: "At least one special character",
                        isShowCheckMark: true,
                        icon: Container(
                          width: 10,
                          height: 10,
                          margin: const EdgeInsets.only(right: 5),
                          child: const Icon(Icons.check),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
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
// ),
// SliverAppBar(
//   pinned: _pinned,
//   snap: _snap,
//   floating: _floating,
//   expandedHeight: 200,
//   backgroundColor: AppColors.mainColor,
//
//   flexibleSpace: FlexibleSpaceBar(
//     centerTitle: false,
//     title: Align(
//       alignment: Alignment.bottomLeft,
//       child: Text(
//         "PLEASE SET A PASSWORD TO SIGNUP",
//         style: TextStyle(
//           fontSize: 18,
//           fontWeight: FontWeight.bold,
//           fontFamily: 'Montserrat',
//         ),
//       ),
//     ),
//     background: Image.network(
//       "https://i.picsum.photos/id/132/200/200.jpg?hmac=meVrCoOURNB7iKK3Mv-yuRrvxvXgv4h2vIRLM4sKwK4",
//       fit: BoxFit.cover,
//     ),
//   ),
// ),
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
