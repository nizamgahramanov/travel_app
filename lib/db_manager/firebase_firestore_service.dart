import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/destination.dart';

class FireStoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> saveDestination(Destination destination) {

    //     .ref()
    //     .child('user_image')
    //     .child(authResult.user!.uid + '.jpg');
    // final refPut = await ref.putFile(image!);
    // final url = await ref.getDownloadURL();
    // print("REFPRI");
    // print(refPut);
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(authResult.user!.uid)
    //     .set({
    //   'username': username,
    //   'email': email,
    //   'image_url': url,
    // });
    return _db
        .collection('destinations')
        .doc((destination.id).toString())
        .set(destination.createMap());
  }

  Stream<List<Destination>> getDestinations() {
    return _db.collection('destinations').snapshots().map((snapshot) => snapshot
        .docs
        .map((document) => Destination.fromFirestore(document.data()))
        .toList());
  }

  // Future<void> removeItem(String productId) {
  //   return _db.collection('Products').document(productId).delete();
  // }
}