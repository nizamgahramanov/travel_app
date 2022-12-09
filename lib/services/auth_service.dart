import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/helpers/app_colors.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/model/user.dart';
import 'package:crypto/crypto.dart';
import '../exception/custom_auth_exception.dart';
import 'firebase_firestore_service.dart';

class AuthService {
  final _firebaseAuth = auth.FirebaseAuth.instance;
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
    print("USER AUTH");
    return _firebaseAuth.authStateChanges().map(_userFromFirebase);
  }

  Future<auth.UserCredential?> signInWithGoogle(BuildContext context) async {
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
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: authError.message,
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: 'Unknown error occurred while processing your request',
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: "Unknown Error");
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
      final userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .whenComplete(() => null);
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
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: authError.message,
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: 'Unknown error occurred while processing your request',
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: e.toString());
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
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: authError.message,
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: 'Unknown error occurred while processing your request',
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: "Unknown Error");
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

  Future<bool> updateUserName(
      BuildContext context, String? firstName, String? lastName) async {
    try {
      await _firebaseAuth.currentUser!
          .updateDisplayName('$firstName $lastName');
      return true;
    } on auth.FirebaseAuthException catch (authError) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: authError.message,
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: 'Unknown error occurred while processing your request',
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: e.toString());
    }
  }

  Future<bool?> updateUserEmail(
      BuildContext context, String? email, String? password) async {
    var userer = _firebaseAuth.currentUser;
    print(userer);
    print("WMIL");
    print(email);
    print(email);

    if (email != null && password != null) {
      try {
        await _firebaseAuth.currentUser!.reauthenticateWithCredential(
          auth.EmailAuthProvider.credential(
              email: userer!.email!, password: password),
        );
        _firebaseAuth.currentUser!.updateEmail(email);
        return true;
      } on auth.FirebaseAuthException catch (authError) {
        Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: 'Oops!',
          alertMessage: authError.message,
          popButtonText: 'Ok',
          popButtonColor: Colors.redAccent,
          onPopTap: () => Navigator.of(context).pop(),
        );
        throw CustomAuthException(context, authError.code, authError.message!);
      } catch (e) {
        Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: 'Oops!',
          alertMessage: 'Unknown error occurred while processing your request',
          popButtonText: 'Ok',
          popButtonColor: Colors.redAccent,
          onPopTap: () => Navigator.of(context).pop(),
        );
        throw CustomException(ctx: context, errorMessage: e.toString());
      }
    }
    return null;
  }

  signOut(BuildContext context) {
    print("SIGN OUT");
    try {
      _firebaseAuth.signOut();
    } on auth.FirebaseAuthException catch (authError) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: authError.message,
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'Oops!',
        alertMessage: 'Unknown error occurred while processing your request',
        popButtonText: 'Ok',
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: e.toString());
    }
  }

  splitGoogleFullName(String? fullName) {
    List<String>? result;
    if (fullName != null) {
      result = fullName.split(" ");
    }
    return result;
  }
}
