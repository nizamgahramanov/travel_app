import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/destination.dart';

class FirebaseStorageService {
  final ref = FirebaseStorage.instance;

  Future<void> saveDestinationImages(Destination destination,File destinationPhoto) {
    final fileRef = ref.ref().child((destination.id).toString()).child("${destination.name}.jpg");

    return fileRef.putFile(destinationPhoto);
  }
  //
  // Stream<List<Destination>> getDestinations() {
  //   return _db.collection('destinations').snapshots().map((snapshot) => snapshot
  //       .docs
  //       .map((document) => Destination.fromFirestore(document.data()))
  //       .toList());
  // }

// Future<void> removeItem(String productId) {
//   return _db.collection('Products').document(productId).delete();
// }
}