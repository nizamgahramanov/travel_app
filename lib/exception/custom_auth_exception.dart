import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/utility.dart';

class CustomAuthException extends FirebaseAuthException {
  CustomAuthException(BuildContext context, String code, String message)
      : super(code: code, message: message) {
    switch (code) {
      // case "user-not-found":
      //   throw CustomException.userNotFound(message);
      // case "wrong-password":
      //   throw CustomException.wrongPassword(message);
      case "user-disabled":
        throw CustomException(ctx: context,errorMessage: message);
      case "invalid-email":
        throw CustomException(ctx: context,errorMessage: message);
      case "email-already-in-use":
        throw CustomException(ctx: context,errorMessage: message);
      case "weak-password":
        throw CustomException(ctx: context,errorMessage: message);
      case "operation-not-allowed":
        throw CustomException(ctx: context,errorMessage: message);
      case "auth/user-not-found":
        throw CustomException(ctx: context,errorMessage: message);
      case "auth/invalid-email":
        throw CustomException(ctx: context,errorMessage: message);
      case "account-exists-with-different-credential":
        throw CustomException(ctx: context,errorMessage: message);
      case "invalid-credential":
        throw CustomException(ctx: context,errorMessage: message);
      case "user-not-found":
        throw CustomException(ctx: context,errorMessage: message);
      case "wrong-password":
        throw CustomException(ctx: context,errorMessage: message);
      case "invalid-verification-code":
        throw CustomException(ctx: context,errorMessage: message);
      case "invalid-verification-id":
        throw CustomException(ctx: context,errorMessage: message);
    }
  }
}

class CustomException extends StatelessWidget {
  final String? errorMessage;
  final BuildContext ctx;
  const CustomException({ required this.ctx,this.errorMessage});

  @override
  Widget build(BuildContext context) {
    print("build");
    return Utility.getInstance().showAlertDialog(
      context: ctx,
      alertTitle: 'Error',
      alertMessage: errorMessage,
      popButtonText: 'Ok',
      popButtonColor: Colors.redAccent,
      onPopTap:()=> Navigator.of(context).pop(),
    );
  }
}

// class CustomException {
//   final String? errorMessage;
//   CustomException({this.errorMessage});
//
//   // factory CustomException.userNotFound(String message) = UserNotFoundException;
//   // factory CustomException.wrongPassword(String message) =
//   // WrongPasswordException;
// }
// class UserNotFoundException extends CustomException {
//   UserNotFoundException(
//     this.message,
//   ) : super(errorMessage: message);
//   final String? message;
// }
//
// class WrongPasswordException extends CustomException {
//   WrongPasswordException(
//     this.message,
//   ) : super(errorMessage: message);
//   final String? message;
// }
