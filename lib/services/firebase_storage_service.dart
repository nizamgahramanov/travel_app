import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/destination.dart';

class FirebaseStorageService {
  final ref = FirebaseStorage.instance;

  Future<List<String>> saveDestinationImages(
      Destination destination, List<File?> destinationPhoto) async {
    int i = 0;
    final List<String> returnedListOfPath = [];
    for (File? imageFile in destinationPhoto) {
      try {
        final fileRef = ref
            .ref()
            .child((destination.id).toString())
            .child("${destination.name}_$i.jpg");

        await fileRef.putFile(imageFile!);

        var url = await fileRef.getDownloadURL();

        returnedListOfPath.add(url);

        i++;
      } catch (err) {
        print(err);
      }
    }
    return returnedListOfPath;
  }
}
