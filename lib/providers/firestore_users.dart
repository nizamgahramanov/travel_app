import 'package:flutter/material.dart';

import '../model/firestore_user.dart';
import '../services/firebase_firestore_service.dart';

class FirestoreUsers with ChangeNotifier{
  final firestore_service = FireStoreService();
  Future<String> findById(String userId) {
    return firestore_service.getUserFromFirestore(userId);
  }
}