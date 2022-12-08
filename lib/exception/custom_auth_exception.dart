import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../helpers/utility.dart';

class CustomAuthException extends FirebaseAuthException {
  CustomAuthException(String code, String message)
      : super(code: code, message: message) {
    switch (code) {
      // case "user-not-found":
      //   throw CustomException.userNotFound(message);
      // case "wrong-password":
      //   throw CustomException.wrongPassword(message);
      case "user-disabled":
        throw CustomException(errorMessage: message);
      case "invalid-email":
        throw CustomException(errorMessage: message);
      case "email-already-in-use":
        throw CustomException(errorMessage: message);
      case "weak-password":
        throw CustomException(errorMessage: message);
      case "operation-not-allowed":
        throw CustomException(errorMessage: message);
      case "auth/user-not-found":
        throw CustomException(errorMessage: message);
      case "auth/invalid-email":
        throw CustomException(errorMessage: message);
      case "account-exists-with-different-credential":
        throw CustomException(errorMessage: message);
      case "invalid-credential":
        throw CustomException(errorMessage: message);
      case "user-not-found":
        throw CustomException(errorMessage: message);
      case "wrong-password":
        throw CustomException(errorMessage: message);
      case "invalid-verification-code":
        throw CustomException(errorMessage: message);
      case "invalid-verification-id":
        throw CustomException(errorMessage: message);
    }
  }
}

class CustomException extends StatelessWidget {
  final String? errorMessage;
  const CustomException({this.errorMessage});

  @override
  Widget build(BuildContext context) {
    print("build");
    return Utility.getInstance().showAlertDialog(
      context: context,
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
//   // factory CustomException.userNotFound(String message) = UserNotFoundException;
//   // factory CustomException.wrongPassword(String message) =
//   // WrongPasswordException;
// }
class UserNotFoundException extends CustomException {
  UserNotFoundException(
    this.message,
  ) : super(errorMessage: message);
  final String? message;
}

class WrongPasswordException extends CustomException {
  WrongPasswordException(
    this.message,
  ) : super(errorMessage: message);
  final String? message;
}
