import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/model/firestore_user.dart';
import 'package:travel_app/services/auth_service.dart';
import 'package:travel_app/services/firebase_firestore_service.dart';

import '../helpers/app_colors.dart';
import '../helpers/custom_button.dart';

class LoginWithPasswordScreen extends StatefulWidget {
  LoginWithPasswordScreen({Key? key}) : super(key: key);
  static const routeName = '/login_with_password';

  String? password;
  @override
  State<LoginWithPasswordScreen> createState() =>
      _LoginWithPasswordScreenState();
}

class _LoginWithPasswordScreenState extends State<LoginWithPasswordScreen> {
  final _login_with_password_form = GlobalKey<FormState>();
  // final o =

  void saveForm() {
    //check in firebase email is registered or not
    FocusScope.of(context).unfocus();
    _login_with_password_form.currentState!.save();
  }

  void isPasswordCorrect(value, context) async {
    //    1. Daxil olan userin emailinə vasitəsi ilə firestoredan məlumatlarını çəkirik
    //    2. Melumatlarda encrypt olunmuş passvordu decrypt edib userin daxil etiyi passvordla yoxlayiriq
    //    3. userin daxil etdiyi passvord dogrudursa home page yoneldirik
    //    4. dogru deyilse dialog gosteririk
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print("ARGS");
    print(args);
    // var result = FireStoreService().getUserFromFirestore(args['email']);
    // print(result);
    final ji =  await FireStoreService().getUserFromFirestore(args['email']);
    print(ji);
    // FutureBuilder(
    //   future: FireStoreService().getUserFromFirestore(args['email']),
    //   builder: (context, AsyncSnapshot<String> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.done) {
    //       // var passwordInBytes = utf8.decoder.convert(args['email']);
    //       // String hashedPassword= sha256.convert(passwordInBytes).toString();
    //       // if(utf8.decoder(snapshot.data). == value)
    //       print("FUTURE BUILDER");
    //       print(snapshot.data);
    //       return Text("JROOR");
    //     } else {
    //       return Text("ERROR");
    //     }
    //   },
    // );
    // await FireStoreService().getUserByEmail(args['email']).then((value) => {
    //   StreamBuilder(stream: ,builder: (BuildContext context, AsyncSnapshot snapshot){
    //
    //   },)
    // });

    // StreamBuilder<FirestoreUser>(
    //   stream: FireStoreService().getUserByEmail(args['email']),
    //   builder: (BuildContext context, AsyncSnapshot<FirestoreUser> snapshot) {
    //     print("SNAPSHOWW T");
    //     print(snapshot);
    //     // return ;
    //   },
    // );
    print("KKKKKK");
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
        backgroundColor: Colors.white,
        elevation: 0.0,
        leading: Container(
          padding: const EdgeInsets.only(left: 10),
          child: const Icon(
            Icons.arrow_back_sharp,
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
                height: 70,
                child: Form(
                  key: _login_with_password_form,
                  child: TextFormField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (enteredText) {
                      setState(() {
                        widget.password = enteredText;
                      });
                      // initSearchDestination(enteredText);
                    },
                    onSaved: (value) {
                      isPasswordCorrect(value, context);
                    },
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      hintText: "Password",
                      suffixIcon: const Icon(Icons.remove_red_eye_rounded),
                      suffixIconColor: AppColors.buttonBackgroundColor,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: CustomButton(
        buttonText: "Done",
        borderRadius: 15,
        margin: 20,
        onTap: saveForm,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
