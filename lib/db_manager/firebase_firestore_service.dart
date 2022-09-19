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
    final a = _db.collection('destinations').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Destination.fromFirestore(document.data()))
        .toList());
    return a;
  }

  // Future<void> removeItem(String productId) {
  //   return _db.collection('Products').document(productId).delete();
  // }
}