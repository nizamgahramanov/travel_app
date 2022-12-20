import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:travel_app/helpers/utility.dart';
import 'package:travel_app/model/user.dart';
import '../exception/custom_auth_exception.dart';
import 'firebase_firestore_service.dart';

class AuthService{
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
      print("Error not here");
      print(googleSignInAccount);
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;

      print("Error not here2");
      print(googleSignInAuthentication);

      final credential = auth.GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      print("Error not here3");

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
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: authError.message,
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      print("error message");
      print(e);
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: 'unknown_error_msg'.tr(),
        popButtonText: 'ok_btn'.tr(),
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
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: authError.message,
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: 'unknown_error_msg'.tr(),
        popButtonText: 'ok_btn'.tr(),
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
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: authError.message,
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: 'unknown_error_msg'.tr(),
        popButtonText: 'ok_btn'.tr(),
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

  void updateUserName(
      BuildContext context, String? firstName, String? lastName) async {
    try {
      await _firebaseAuth.currentUser!
          .updateDisplayName('$firstName $lastName')
          .then((_) {
        FireStoreService().updateUserName(
            firstName, lastName, _firebaseAuth.currentUser!.uid);
      }).catchError((authError) {
        print("ERRROR HAPPPENENEDEDEDE");
        print(authError.message);
        Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: 'oops_error_title'.tr(),
          alertMessage: authError.message,
          popButtonText: 'ok_btn'.tr(),
          popButtonColor: Colors.redAccent,
          onPopTap: () => Navigator.of(context).pop(),
        );
      });
    } on auth.FirebaseAuthException catch (authError) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: authError.message,
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: 'unknown_error_msg'.tr(),
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomException(ctx: context, errorMessage: e.toString());
    }
  }

  void updateUserEmail(
      BuildContext context, String? email, String? password) async {
    if (email != null && password != null) {
      try {
        await _firebaseAuth.currentUser!.reauthenticateWithCredential(
          auth.EmailAuthProvider.credential(
              email: _firebaseAuth.currentUser!.email!, password: password),
        );
        print("Update user eamil");
        _firebaseAuth.currentUser!.updateEmail(email).then((_) {
          print("THEN BLOCK FIREDS");
          FireStoreService().updateUserEmail(
            email,
            _firebaseAuth.currentUser!.uid,
          );
        }).catchError((authError) {
          print("ERRROR HAPPPENENEDEDEDE");
          print(authError.message);
          Utility.getInstance().showAlertDialog(
            context: context,
            alertTitle: 'oops_error_title'.tr(),
            alertMessage: authError.message,
            popButtonText: 'ok_btn'.tr(),
            popButtonColor: Colors.redAccent,
            onPopTap: () => Navigator.of(context).pop(),
          );
        });
      } on auth.FirebaseAuthException catch (authError) {
        Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: 'oops_error_title'.tr(),
          alertMessage: authError.message,
          popButtonText: 'ok_btn'.tr(),
          popButtonColor: Colors.redAccent,
          onPopTap: () => Navigator.of(context).pop(),
        );
        throw CustomAuthException(context, authError.code, authError.message!);
      } catch (e) {
        Utility.getInstance().showAlertDialog(
          context: context,
          alertTitle: 'oops_error_title'.tr(),
          alertMessage: 'unknown_error_msg'.tr(),
          popButtonText: 'ok_btn'.tr(),
          popButtonColor: Colors.redAccent,
          onPopTap: () => Navigator.of(context).pop(),
        );
        throw CustomException(ctx: context, errorMessage: e.toString());
      }
    }
  }

  signOut(BuildContext context) {
    print("SIGN OUT");
    try {
      _firebaseAuth.signOut();
    } on auth.FirebaseAuthException catch (authError) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: authError.message,
        popButtonText: 'ok_btn'.tr(),
        popButtonColor: Colors.redAccent,
        onPopTap: () => Navigator.of(context).pop(),
      );
      throw CustomAuthException(context, authError.code, authError.message!);
    } catch (e) {
      Utility.getInstance().showAlertDialog(
        context: context,
        alertTitle: 'oops_error_title'.tr(),
        alertMessage: 'unknown_error_msg'.tr(),
        popButtonText: 'ok_btn'.tr(),
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
