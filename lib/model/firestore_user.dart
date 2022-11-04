class FirestoreUser {
  final String email;
  final String firstName;
  final String lastName;
  final String password;

  FirestoreUser(
    this.email,
    this.firstName,
    this.lastName,
    this.password,
  );

  FirestoreUser.fromFirestore(Map<String, dynamic> firestoreMap)
      : email = firestoreMap['email'],
        firstName = firestoreMap['firstName'],
        lastName = firestoreMap['lastName'],
        password = firestoreMap['password'];
}
