import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/destination.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDestination(Destination destination) {
    return _db
        .collection('destinations')
        .doc((destination.id).toString())
        .set(destination.createMap());
  }

  Stream<List<Destination>> getDestinations() {
    final a = _db.collection('destinations').snapshots().map((snapshot) =>
        snapshot.docs
            .map((document) => Destination.fromFirestore(document.data()))
            .toList());
    return a;
  }

  Stream<List<Destination>> getDestinationsBySearchText(String enteredText) {
    print("ENTERED TEXT");
    print(enteredText);
    final a = _db
        .collection('destinations')
        .where("name", isGreaterThanOrEqualTo: enteredText)
        .where("name", isLessThan: "${enteredText}z")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Destination.fromFirestore(document.data()))
            .toList());
    return a;
  }

  //This method is used to create the user in firestore
  Future<void> createUserInFirestore(String uid, String firstName,String lastName, String email, String password) async {
    //Creates the user doc named whatever the user uid is in te collection "users"
    //and adds the user data
    await _db.collection("users").doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email' : email,
      'password':password
    });
  }


// Future<void> removeItem(String productId) {
  //   return _db.collection('Products').document(productId).delete();
  // }
}
