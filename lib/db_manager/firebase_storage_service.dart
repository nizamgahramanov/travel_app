import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import '../model/destination.dart';

class FirebaseStorageService {
  final ref = FirebaseStorage.instance;

  Future<List<String>> saveDestinationImages(Destination destination, List<File?> destinationPhoto) async {
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
        print("I VALUE");
        print(i);
      } catch (err) {
        print(err);
      }
    }
    return returnedListOfPath;
    // notifyListeners();
    // print(_imagesUrl);
  }
  //   // final refPut = await fileRef.putFile(destinationPhoto);
  //   // final url = await fileRef.getDownloadURL();
  //   print("URL LIST");
  //   print(returnedListofPath);
  //   return returnedListofPath;
    //   UploadTask uploadTask = fileRef.putFile(destinationPhoto);
    //   print("GETTING URL FROM");
    //   String url="";
    //   await uploadTask.whenComplete(() {
    //     fileRef.getDownloadURL().then((fileURL){
    //       print("GET DOWNLOAD URL");
    //       url = fileURL;
    //       print(url);
    //       return url;
    //     });
    //   });
    //   // final url = fileRef.getDownloadURL();
    //   // print("URL");
    //   print(url);
    // return url;
  // }
}
