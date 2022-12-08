import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:travel_app/services/en_de_cryption.dart';
import '../model/destination.dart';
import '../model/firestore_user.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final User? _firebaseAuth = FirebaseAuth.instance.currentUser;
  // FirebaseFirestore.instance.collection("favorites").doc(FirebaseAuth.instance.currentUser!.uid).collection("items").where("id", isEqualTo: clickedDestination.id).snapshots()
  Future<void> saveDestination(Destination destination) {
    return _db
        .collection('destinations')
        .doc((destination.id).toString())
        .set(destination.createMap());
  }

  // StreamSubscription<QuerySnapshot> listen(void onData(QuerySnapshot event)?,String destinationId,
  //     {Function? onError, void onDone()?, bool? cancelOnError}){
  //   var a = isDestinationFavorite()
  //   return
  // };

  Future<bool> isDestinationFavoriteFuture(String destinationId) async {
    final snapshot = await _db
        .collection("favorites")
        .doc(_firebaseAuth!.uid)
        .collection('items')
        .where("id", isEqualTo: destinationId)
        .get();
    return snapshot.docs.isEmpty;
  }

  void toggleFavorites(String uid, Destination destination) async {
    bool isFavorite = await isDestinationFavoriteFuture(destination.id!);
    if (isFavorite) {
      _db
          .collection("favorites")
          .doc(uid)
          .collection("items")
          .doc(destination.id)
          .set(destination.createMap());
    } else {
      _db
          .collection("favorites")
          .doc(uid)
          .collection("items")
          .doc(destination.id)
          .delete();
    }

    // return _db.collection("favorites").doc(userId).update({
    //   "favorites": FieldValue.arrayUnion([destinationId])
    // });
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
  Future<void> createUserInFirestore(String uid, String? firstName,
      String? lastName, String email, String? password) async {
    //Encrypts password before store in firestore
    String? encryptedPassword;
    if (password != null) {
      encryptedPassword = EnDeCryption().encryptWithAES(password).base16;
    }

    print("encrypted");
    print(encryptedPassword);
    var firestoreUserItem = FirestoreUser(
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: encryptedPassword,
    );
    //Creates the user doc named whatever the user uid is in the collection "users"
    //and adds the user data
    // await _db.collection("users").doc(uid).set({
    //   'email': email,
    //   'firstName': firstName,
    //   'lastName': lastName,
    //   'password': encrypted.base16
    // });
    await _db.collection("users").doc(uid).set(firestoreUserItem.createMap());
  }

  Stream<FirestoreUser> getUserByEmail(String email) {
    return _db
        .collection("users")
        .where("email", isEqualTo: email)
        .snapshots()
        .map((event) =>
            event.docs.map((e) => FirestoreUser.fromFirestore(e.data())).first);
  }

  Future<String?> getUserPasswordFromFirestore(String email) async {
    final snapshot =
        await _db.collection("users").where("email", isEqualTo: email).get();
    print(snapshot.docs.isEmpty);
    if (snapshot.docs.isEmpty) {
      return null;
    } else {
      return snapshot.docs.first['password'];
    }
  }

  Future<FirestoreUser> getUserByUID(String uid) {
    return _db
        .collection("users")
        .doc(uid)
        .get()
        .then((value) => FirestoreUser.fromFirestore(value.data()!));
  }

  Future<List<dynamic>> getUserByUid(String uid) {
    return _db.collection("users").doc(uid).get().then((value) {
      print("value");
      print(value.exists);
      print(value);
      return value.data()!['favorites'];
    });
  }

  Stream<QuerySnapshot> isDestinationFavorite(String destinationId) {
    return _db
        .collection("favorites")
        .doc(_firebaseAuth!.uid)
        .collection("items")
        .where("id", isEqualTo: destinationId)
        .snapshots();
  }

  Stream<List<Destination>> getFavoriteList() {
    final favoriteList = _db
        .collection('favorites')
        .doc(_firebaseAuth!.uid)
        .collection("items")
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((document) => Destination.fromFirestore(document.data()))
            .toList());
    return favoriteList;
  }

  updateUserName(String? firstName, String? lastName, String? uid) {
    print("updateUserName");
    if (uid != null) {
      DocumentReference docRef = _db.collection('users').doc(uid);
      var batch = _db.batch();
      batch.update(docRef, {'firstName': firstName, 'lastName': lastName});
      batch.commit();
    }
  }

  updateUserEmail(String? email, String? uid) {
    print("updateUserName");
    if (uid != null) {
      DocumentReference docRef = _db.collection('users').doc(uid);
      var batch = _db.batch();
      batch.update(docRef, {'email': email});
      batch.commit();
    }
  }
}
