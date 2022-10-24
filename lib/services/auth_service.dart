import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/screen/login_signup_screen.dart';
import 'package:travel_app/screen/main_screen.dart';

import '../helpers/custom_snackbar.dart';

class AuthService {
  // handleAuthState() {
  //   print("ASDASDASDA");
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         print("SNAPSHOW");
  //         print(snapshot);
  //         if (snapshot.hasData) {
  //           print("DATAAAA ");
  //           print(snapshot.data);
  //           return snapshot.data;
  //         } else {
  //           return
  //         }
  //       });
  // }

  Future<UserCredential?> signInWithGoogle({required BuildContext context}) async {
    try {
      print("signInWithGoogle");
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
           AuthService.customSnackBar(content: 'The account already exists with a different credential.')

        );
      } else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(
          AuthService.customSnackBar(
            content: 'Error occurred while accessing credentials. Try again.',
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        AuthService.customSnackBar(
          content: 'Error occurred using Google Sign-In. Try again.',
        ),
      );
    }
    return null;
  }
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }
  
  signOut() {
    print("SIGN OUT");
    FirebaseAuth.instance.signOut();
  }
}
