class FirestoreUser {
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final List<String> favorites;

  FirestoreUser({
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.favorites,
  });

  Map<String, dynamic> createMap() {
    return {
      'email': email,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'favorites': favorites,
    };
  }

  FirestoreUser.fromFirestore(Map<String, dynamic> firestoreMap)
      : email = firestoreMap['email'],
        firstName = firestoreMap['firstName'],
        lastName = firestoreMap['lastName'],
        password = firestoreMap['password'],
        favorites = firestoreMap['favorites'];
}
