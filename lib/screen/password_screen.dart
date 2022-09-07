import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_colors.dart';

class PasswordScreen extends StatefulWidget {
  static const routeName = '/password';
  const PasswordScreen({Key? key}) : super(key: key);

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {
  final _form = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.mainColor,
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.maxFinite,
            child: Stack(
              children: [
                Positioned(
                  child: Image.network(
                    "https://i.picsum.photos/id/454/200/200.jpg?hmac=N13wDge6Ku6Eg_LxRRsrfzC1A4ZkpCScOEp-hH-PwHg",
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.6,
            child: Form(
              key: _form,
              child: TextFormField(
                decoration: InputDecoration(
                  
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: AppColors.buttonBackgroundColor,
                    ),
                  ),
                  labelText: "Password",
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
          )
        ],
      )),
    );
  }
}
