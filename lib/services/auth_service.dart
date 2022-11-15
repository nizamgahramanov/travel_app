import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/model/user.dart';
import 'package:crypto/crypto.dart';
import '../exception/custom_auth_exception.dart';
import 'firebase_firestore_service.dart';

class AuthService {
  final _firebaseAuth = auth.FirebaseAuth.instance;
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
  User? _userFromFirebase(auth.User? user) {
    if (user == null) {
      return null;
    }
    return User(
      uid: user.uid,
      email: user.email!,
    );
  }

  Stream<User?>? get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<auth.UserCredential?> signInWithGoogle() async {
    try {
      print("signInWithGoogle");
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn(scopes: <String>["email"]).signIn();

      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print(googleSignInAccount);

      auth.UserCredential result =
          await _firebaseAuth.signInWithCredential(credential);
      if (result.user != null) {
        List<String>? nameAndSurname =
            splitGoogleFullName(result.user!.displayName);
        FireStoreService().createUserInFirestore(
          result.user!.uid,
          nameAndSurname == null ? null : nameAndSurname[0],
          nameAndSurname == null ? null : nameAndSurname[1],
          result.user!.email!,
          null,
        );
      }

      return result;
    } on auth.FirebaseAuthException catch (authError) {
      throw CustomAuthException(authError.code, authError.message!);
    } catch (e) {
      throw CustomException(errorMessage: "Unknown Error");
    }
  }

  Future<User?> registerUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String email,
    required String password,
  }) async {
    try {
      print("signInWithEmailAndPassword");
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        FireStoreService().createUserInFirestore(
          userCredential.user!.uid,
          firstName,
          lastName,
          email,
          password,
        );
      }

      return _userFromFirebase(userCredential.user);
    } on auth.FirebaseAuthException catch (authError) {
      throw CustomAuthException(authError.code, authError.message!);
    } catch (e) {
      throw CustomException(errorMessage: e.toString());
    }
  }

  Future<User?> loginUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      print("signInWithEmailAndPassword");

      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _userFromFirebase(userCredential.user);
    } on auth.FirebaseAuthException catch (authError) {
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

  splitGoogleFullName(String? fullName) {
    List<String>? result;
    if (fullName != null) {
      result = fullName.split(" ");
    }
    return result;
  }
}
