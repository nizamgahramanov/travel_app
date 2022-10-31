import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/screen/login_signup_screen.dart';
import 'package:travel_app/screen/main_screen.dart';

import '../exception/custom_auth_exception.dart';
import '../helpers/custom_snackbar.dart';

class AuthService {
  final _firebaseAuth = FirebaseAuth.instance;
  // Stream<User?> handleAuthState() async{
  //   print("ASDASDASDA");
  //   return StreamBuilder(
  //       stream: await FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         print("SNAPSHOW");
  //         print(snapshot);
  //         if (snapshot.hasData) {
  //           print("DATAAAA ");
  //           print(snapshot.data);
  //           return snapshot.;
  //         } else {
  //           return ;
  //         }
  //       });
  // }
  Stream<User?> get onAuthStateChanged => _firebaseAuth.authStateChanges();

  Future<UserCredential?> signInWithGoogle(
      {required BuildContext context}) async {
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

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        ScaffoldMessenger.of(context).showSnackBar(AuthService.customSnackBar(
            content:
                'The account already exists with a different credential.'));
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

  Future<UserCredential> registerUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      print("signInWithEmailAndPassword");

      return await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (authError) {
      throw CustomAuthException(authError.code, authError.message!);
    } catch (e) {
      throw CustomException(errorMessage: "Unknown Error");
    }
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
    _firebaseAuth.signOut();
  }
}
